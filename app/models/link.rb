class Link < ActiveRecord::Base
  validates :url, :presence => true, :format => {:with => URI::regexp(%w(http https))}
end
