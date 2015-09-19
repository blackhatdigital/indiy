require 'spec_helper'

feature "user creates and account and signs in" do
  background { User.create(username: "bob", password: "password", email: "email@example.com")}
  scenario "user creates an account and gets auto signed in" do
    visit "/"
    click_link "Sign Up"
    fill_in "Username", with: "Demo"
    fill_in "Password", with: "Password"
    fill_in "Email", with: "demo@example.com"
    click_button "Create Account"
    expect(page).to have_content "Thank you for joining"
  end

  scenario "previously registered user signs in" do
    visit "/"
    click_link "Log In"
    fill_in "Username", with: "bob"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(page).to have_content "bob's Dashboard"
  end
end