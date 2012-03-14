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
end
