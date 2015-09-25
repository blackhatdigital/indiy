require 'spec_helper'

describe ProductsController do
  describe "GET new" do
    before { Fabricate(:user, stripe_user_id: "not nil"); session[:user_id] = User.first.id}
    it "renders the new product template" do
      get :new, {:user_id => User.first}
      expect(response).to render_template :new
    end
    it "redirects the user to the dashboard if they are not connected to stripe" do
      User.first.update!(stripe_user_id: nil)
      get :new, {user_id: User.first}
      expect(response).to redirect_to user_path(User.first)
    end
    it "sets the flash message" do
      User.first.update!(stripe_user_id: nil)
      get :new, {user_id: User.first}
      expect(flash[:danger]).to eq("You need to connect to Stripe before you can upload a product.")
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    before {session[:user_id] = user.id}

    context "with valid content" do
      before {post :create, user_id: user.id, product: {user_id: user.id, name: "product", short_description: "lalala", long_description: "lalalalalalalla", price: 999}}
      it "persists the product to the database" do
        expect(Product.count).to eq(1)
      end

      it "associates the product with the user" do
        expect(User.first.products.count).to eq(1)
      end
    end

    context "with invalid content" do
      it "renders the new template" do
        post :create, user_id: user.id, product: {name: "bob"}
        expect(response).to render_template :new
      end
    end
  end
end