require 'spec_helper'

describe ConnectController do
  describe "GET CREATE" do
    context "access granted" do
      before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:stripe_connect]
        @alice = Fabricate(:user)
        session[:user_id] = @alice.id
        post :create
      end
      it "saves the publishabe key to the users table" do
        expect(User.first.publishable_key).to eq("pk_test_pI5GJFdaKP2bp2nQlZ5Ij4BA")
      end
      it "saves the stripe user id to the users table" do
        expect(User.first.stripe_user_id).to eq("acct_16FzCIKvv4sqfP0N")
      end
      it "saves the stripe token to the users table" do
        expect(User.first.secret_key).to eq("sk_test_d5m8oIS5HW0qEun5Wg0eH5bq")
      end
    end
  end
end