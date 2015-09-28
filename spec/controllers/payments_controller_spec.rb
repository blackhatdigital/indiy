require 'spec_helper'

describe PaymentsController do
  let(:user) {Fabricate(:user)}
  let(:product) {Fabricate(:product, name: "good item", price: 100, user: user)}
  describe "GET new" do
    before { get :new, {user_id: user.id,product_id: product.id}}
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET index" do
    before do
      session[:user_id] = user.id
      @pay1 = Payment.create(product_id: product.id, price: 100)
      @pay2 = Payment.create(product_id: product.id, price: 100)
      get :index, product_id: product.id, user_id: user.id
    end
    it "loads all the product payments into a variable, order desc" do
      expect(assigns(:payments)).to eq([@pay2,@pay1])
    end
    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

  describe "POST create" do
    before do 
      StripeWrapper::Charge.stub(:create).and_return(charge)
      post :create, user_id: user.id,product_id: product.id, payment: {name: "bob", email: "roger@gmail.com", price: product.price.to_i,product_id: product.id,receipt: "asdfsefsd"}
    end
    context "successful charge" do
      let(:charge) { double(:charge, successful?: true, receipt: "123456") }
      it "saves payment to the database" do
        expect(Payment.count).to eq(1)
      end
      it "saves the receipt number to the database" do
        expect(Payment.first.receipt).to eq('123456')
      end
      it "Sends an invoice email" do
        expect(ActionMailer::Base.deliveries.last.body).to have_content("Thank you for purchasing good item.")
      end
      it "redirects to the download page" do
        expect(response).to redirect_to user_product_payment_path(user,product,Payment.first,:params => {email: Payment.first.email})
      end
      it "associates the payment with the product" do
        expect(Payment.first.product).to eq(product)
      end
    end
    context "failed charge" do
      let(:charge) {double(:charge,successful?: false, receipt: "aalas", error_message: "declined maggot.")}
      it "renders the new template" do
        expect(response).to render_template(:new)
      end
      it "does not create a payment" do
        expect(Payment.all.count).to eq(0)
      end
      it "sets the error message" do
        expect(flash[:danger]).to eq("declined maggot.")
      end
    end
  end

  describe "GET show" do
    before { Payment.create(email: "bob@gmail.com", product_id: product.id) }
    context "valid user" do
      before { get :show, user_id: user.id, product_id: product.id, id: Payment.first.id, email: Payment.first.email }
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
    end

    context "invalid user" do
      before { get :show, user_id: user.id, product_id: product.id, id: Payment.first.id, email: "wrong@gmail.com"}
      it "sets the flash[:danger] message" do
        expect(flash[:danger]).to eq("You are not authorised to access that page.")
      end
      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end