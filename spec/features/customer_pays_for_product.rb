require 'spec_helper'

feature "Customer pays for product on the test payments page" do
  background do
    Fabricate(:user, stripe_user_id: "acct_16FzCIKvv4sqfP0N")
  end
  scenario "customer pays with valid card"
  scenario "customer pays with invalid card"
  scenario "customer pays with declined card"
end