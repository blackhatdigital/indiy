require 'spec_helper'

describe PaymentsController do
  let(:user) {Fabricate(:user)}
  let(:product) {Fabricate(:product, price: 100, user: user)}
  describe "GET new" do
    before { get :new, {user_id: user.id,product_id: product.id}}
    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "GET index" do
    before do
      Payment.create(product_id: product.id, price: 100)
      get :index, product_id: product.id, user_id: user.id
    end
    it "loads all the product payments into a variable" do
      expect(assigns(:payments)).to eq([Payment.first])
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
      let(:charge) { double(:charge, successful?: true, customer_token: "askl") }
      it "saves payment to the database" do
        expect(Payment.count).to eq(1)
      end
      it "redirects to the product page" do
        expect(response).to redirect_to user_product_path(user,product)
      end
      it "associates the payment with the product" do
        expect(Payment.first.product).to eq(product)
      end
    end
    context "failed charge" do
      let(:charge) {double(:charge,successful?: false, customer_token: "aalas", error_message: "declined maggot.")}
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

end