require 'spec_helper'

describe Link do
 
  it "requires a url" do
    should_not be_valid
    subject.errors[:url].should_not be_empty
  end
  
  it "requires a valid url" do
    @invalid_link = Link.new(:url => "12349920 invalid")
    @invalid_link.should_not be_valid
    @valid_link = Link.new(:url => "https://www.pivotaltracker.com/projects/500485")
    @valid_link.should be_valid
  end
  it 'returns the url for the title if Pismo cannot find a title' do
    @no_title = Link.new(:url => "http://web.archive.org/web/20050324062234/http:/ycombinator.com/")
    @no_title.save 
    @no_title.title.should_not be_nil
  end
  
  it 'requires a unique url to that user' do
    @first_url = Link.new(:url => "https://www.pivotaltracker.com/projects/500485", :user_id => 1)
    @first_url.save
    @repeat_url = Link.new(:url => "https://www.pivotaltracker.com/projects/500485", :user_id => 1)
    @repeat_url.should_not be_valid
  end
  
    
end
