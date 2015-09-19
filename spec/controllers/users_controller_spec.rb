require 'spec_helper'

describe UsersController do
  describe "POST create" do
    context "valid input" do
      before { post :create, user: {username: "bob", password: "steve", email: "rohan@gmail.com"}}
      it "creates a new user" do
        expect(User.count).to eq(1)
      end
      it "sets the current session id to the user id" do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "redirects to the thank you page" do
        expect(response).to redirect_to thankyou_path
      end
    end
    context "invalid input" do
      it "does not create a new user" do
        post :create, user: {username: "bob"}
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        post :create, user: {username: "bob"}
        expect(response).to render_template :new
      end
      it "sets the flash error message(s)" do
        post :create, user: {username: "bob"}
        expect(flash[:danger]).to eq("Invalid information given, check errors below.")
      end
    end
  end
end