require 'spec_helper'

describe LinksController do
  include Devise::TestHelpers
  
  before(:each) do
    @user = Factory.create(:user)
    sign_in @user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "assigns @link" do
      get 'new'
      assigns[:link].should_not be_nil
      assigns[:link].should be_instance_of(Link)
    end
  end
  
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  
  describe "GET 'create'" do
    
    context "successful save" do
      
      let(:successful_params) do
        {:link => {:url => 'http://www.google.com'}}
      end
      
      it 'saves the link' do
        expect {
          post :create, successful_params
        }.to change(Link, :count).by(1)
      end
      
      it 'redirects to links index' do
        post :create, successful_params
        response.should redirect_to(user_path(@user))
      end
      
      it 'provides a success message' do
        post :create, successful_params
        flash[:success].should == "Added a link"
      end
    end
    
    
    context "unsuccessful save" do
      
      let(:failing_params) do
        { :link => {:url => 'invalid url'} }
      end
      
      it 'does not save the link' do
        expect {
          post :create, failing_params
        }.to_not change(Link, :count)
      end
      
      it 'renders the "new" template' do
        post :create, failing_params
        response.should be_success
        response.should render_template('new')
      end
      
      # it "provides an error message" do
      #   post :create, failing_params
      #   response.should have_content "invalid url"
      # end
    end
  end
end
