class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :presence => true, :format => {:with => URI::regexp(%w(http https))}
  
  before_validation :add_url_prefix
  
  before_save :populate_title_and_description, :add_display_url
  
  default_scope order: 'links.created_at DESC'
  
 
  
  private
  
  def add_url_prefix
    self.url = self.url.gsub(" ", "")
    self.url = "http://#{url}"  unless url.start_with?("http://","https://")
  end
  
  def add_display_url
    slash_index = self.url.index("/", 7)
    self.display_url = self.url[0..slash_index]
  end
  
  def populate_title_and_description
    # Fill in title /description automatically on first save
    if self.new_record?
      doc = Pismo::Document.new(url)
      self.title = doc.titles[-1] # small bug in pismo, several titles available, one in head seems best
      if doc.description
        self.description = doc.description
      else
        self.description = format_description(doc.lede)
      end
    end
  end
  
  def format_description string
    "#{string[0..150].split[0..-2].join(' ')} ..."
  end
end
