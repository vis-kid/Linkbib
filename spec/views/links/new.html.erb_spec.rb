require 'spec_helper'

describe "links/new.html.erb" do
  context "form" do
    before do
      assign(:link, Link.new)
      render
    end
  
    it "should have a form for creating links" do
      rendered.should have_tag('form', :with => { :action => '/links', :method => 'post'}) do
        with_tag 'input', :with => { :name => 'link[url]' }
      end
    end
  end
  
  context "errors" do
    before do
      link = Link.new
      link.valid?
      assign(:link, link)
      render
    end
    
    it "displays errors when link saving fails" do
      rendered.should have_content("can't be blank")
    end
  end
end
