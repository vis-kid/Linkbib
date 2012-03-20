require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "has a link to the current users profile" do
      visit root_path
      page.should have_content "profile"
    end
  end

end
