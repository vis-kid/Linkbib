require 'spec_helper'

describe UsersController do
  
  describe "signin" do
      before { visit new_user_session_path }
  
    describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        it "returns http success" do
          visit user_path(user)
          response.should be_success
        end
        # 
        # it { should have_selector('title', text: user.name) }
        # it { should have_link('Profile', href: user_path(user)) }
        # it { should have_link('Sign out', href: signout_path) }
        # it { should_not have_link('Sign in', href: signin_path) }

    end
  end
  # 
  # describe "GET 'show'" do
  #   it "returns http success" do
  #     get 'show'
  #     response.should be_success
  #   end
  # end

end
