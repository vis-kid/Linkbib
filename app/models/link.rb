class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :presence => true, :format => {:with => URI::regexp(%w(http https))}
  
  before_validation :add_url_prefix
  before_save :populate_title_and_description
  
  private
  
  def add_url_prefix
    self.url = "http://#{url}" unless url.start_with?("http://","https://")
  end
  
  def populate_title_and_description
    doc = Pismo::Document.new(url)
    self.title = doc.title
    if doc.description
      self.description = doc.description
    else
      self.description = format_description(doc.lede)
    end
  end
  
  def format_description string
    "#{string[0..150].split[0..-2].join(' ')} ..."
  end
end
