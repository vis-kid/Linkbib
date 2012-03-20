require 'spec_helper'

describe "Layouts" do
  describe "links in the navbar" do
    

    describe "when not signed in" do
      
      it "should have signup links" do
        visit root_path
        click_link "Sign up"
        page.should have_selector("a", :href => new_user_registration_path, :content => "Sign up")
      end
      
      it "should have signin links" do
        visit root_path
        click_link "Sign in"
        
        page.should have_selector("a", :href => new_user_session_path, :content => "Sign in")
      end
        
    end
    
    describe "when signed in" do
      before do
        @user = Factory(:user)
        visit new_user_registration_path
        fill_in "Email", :with => @user.email
        fill_in "Password", :with => @user.password
        fill_in "Password confirmation", :with => @user.password
        click_button "Sign up"
      end
      
      it "should have a signout link" do
        page.should have_selector("a", :href => destroy_user_session_path, :content => "Sign out")
      end
      
      it "should have a profile link" do
        page.should have_selector("a", :href => users_path(@user), :content => "Profile")
      end
    end
  end
end
