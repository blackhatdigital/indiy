require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    before { User.create(username: "bob", password: "password", email: "email@example.com") }
    context "successful login info" do
      before { post :create, username: "bob", password: "password" }
      it "sets the session variable" do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it "redirects to the user page" do
        expect(response).to redirect_to user_path(User.first)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to eq("You Have Successfully Signed In!")
      end
    end
    context "unsuccessful login info" do
      before { post :create, username: "joe", password: "invalid"}
      it "does not set the session variable" do
        expect(session[:user_id]).not_to be_present
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets the flash error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end