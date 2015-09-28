require 'spec_helper'

describe StripeWrapper do
  before {Stripe.api_key = ENV["STRIPE_SECRET"]}
  let(:token) do
    Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 6,
        exp_year: 2018,
        cvc: 314
      }).id
  end
  describe StripeWrapper::Charge do
    let(:account_key) { ENV['STRIPE_TEST_CONNECTED_ACCOUNT']}
    describe ".create" do
      context "with valid card", :vcr do
        let(:card_number) { '4242424242424242' }
        it "makes a successful charge" do
          charge = StripeWrapper::Charge.create(amount: 1000, source: token, account: account_key, fee: (1000*4/100))
          expect(charge).to be_successful
        end

        it "sets the application fee to 4%" do
          charge = StripeWrapper::Charge.create(amount: 1000, source: token, account: account_key, fee: (1000*4/100))
          expect(charge.fee).to eq("fee_74307s9XdnrpN0")
        end
        it "returns a receipt number" do
          charge = StripeWrapper::Charge.create(amount: 1000, source: token, account: account_key, fee: (1000*4/100))
          expect(charge.receipt).to be_present
        end
      end

      context "with invalid card", :vcr do
        let(:card_number) { '4000000000000002' }
        let(:response) { StripeWrapper::Charge.create(amount: 1000, source: token, account: account_key, fee: (1000*4/100)) }
        it "does not make a successful charge" do
          expect(response).not_to be_successful
        end
        it "contains an error message" do
          expect(response.error_message).to be_present
        end
      end
    end
  end
end