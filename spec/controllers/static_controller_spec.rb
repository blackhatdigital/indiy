require 'spec_helper'

describe StaticController, :type => :controller do

  describe "GET landing" do
    it "isnt available to logged_in users" do
      @user = Fabricate(:user)
      session[:user_id] = @user.id
      get :landing
      expect(response).to redirect_to user_path(@user)
    end
  end
  describe "GET how_it_works" do
    it "renders the template" do
      get :how_it_works
      expect(response).to render_template :how_it_works
    end
  end

  describe "GET pricing" do
    it "renders the template" do
      get :pricing
      expect(response).to render_template :pricing
    end
  end

  describe "GET thank-you" do
    it "renders the template" do
      get :thank_you
      expect(response).to render_template :thank_you
    end
  end
end