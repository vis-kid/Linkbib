require 'spec_helper'

describe "UserAccountsAndProfiles" do
  
  it "allows a new user to sign up" do
    visit root_path
    click_link "Sign up"
    fill_in "Email", :with => "foo@bar.com"
    fill_in "Password", :with => 'password'
    fill_in "Password confirmation", :with => 'password'
    click_button "Sign up"
    #page.should have_content "signed up"
    click_link "Sign out"
    #page.should have_content "signed out"
  end
  
  it "allows a user to sign in"
  it "allows a user to view and add links to his profile"

end
