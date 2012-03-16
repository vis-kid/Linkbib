class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :presence => true, :format => {:with => URI::regexp(%w(http https))}
  
  before_validation :add_url_prefix
  
  before_save :add_display_url, :populate_title_and_description
  
  default_scope order: 'links.created_at DESC'
  
  private
  
  def add_url_prefix
    self.url = self.url.gsub(" ", "")
    self.url = "http://#{url}"  unless url.start_with?("http://","https://")
  end
  
  def add_display_url
    fixed_url = self.url.gsub(/https?:\/\/w?w?w?\.?/, "")
    slash_index = fixed_url.index("/")
    self.display_url = fixed_url[0..slash_index-1]
    @domain = self.display_url
  end
  
  def populate_title_and_description
    # Fill in title /description automatically on first save
    if self.new_record?
      doc = Pismo::Document.new(url)
      self.title = doc.html_title # small bug in pismo, several titles available, one in head seems best
      if doc.description
        self.description = format_description doc.description
      else
        self.description = format_description(doc.lede) if doc.lede
      end
      if doc.favicon
        self.favicon_url = doc.favicon
      else
        self.favicon_url = find_favicon
        #self.favicon_url = "/assets/globe_favicon_16x16.ico"
        
      end
    end
  end
  
  def find_favicon 
    self.favicon_url = "http://www.google.com/s2/favicons?domain=#{@domain}"
  end
  
  def format_description string
    string[0..220].split[0..-2].join(' ')
  end
end
