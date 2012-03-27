class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :presence => true, :format => {:with => URI::regexp(%w(http https))}
  validates_uniqueness_of :url, :scope => :user_id
  after_validation :add_url_prefix
  before_save :add_display_url, :populate_title_and_description, :ensure_title_format, :ensure_description_format
  default_scope order: 'links.created_at DESC'
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private
  
  def self.followed_by(user)
    following_ids = %(SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id)
    where("user_id IN (#{following_ids}) OR user_id = :user_id",
      { :user_id => user })
  end
  
  def add_url_prefix
    if self.url
      self.url = self.url.gsub(" ", "")
      self.url = "http://#{url}"  unless url.start_with?("http://","https://")
    end
  end
  
  def add_display_url
    fixed_url = self.url.gsub(/https?:\/\/(www)?\.?/, "")
    slash_index = fixed_url.index("/")
    if slash_index
      self.display_url = fixed_url[0..slash_index-1]
    else
      self.display_url = fixed_url
    end
  end
  
  def populate_title_and_description
    if self.new_record?
      begin
        doc = Pismo::Document.new(url)
        if doc.html_title
          self.title = doc.html_title
          self.display_title = title_format doc.html_title
        else
          self.title, self.display_title = self.url
        end
        if doc.description.blank? || doc.description.nil?
          self.description = description_format(doc.lede) if doc.lede
        else 
          self.description = description_format doc.description
        end
        self.favicon_url = find_favicon
        if doc.author
          self.author = author_format doc.author
        end
      rescue
        self.title = url
        self.display_title = url
      end
    end
  end
  
  def find_favicon 
    self.favicon_url = "http://www.google.com/s2/favicons?domain=#{self.display_url}"
  end
  
  def author_format author
    if author.downcase.include?("and")
      (author.downcase.split(' ').each {|word| word.capitalize!}).join(' ').gsub("And ", "and ")
    else
      (author.downcase.split(' ').each {|word| word.capitalize!}).join(' ')
    end
  end
  
  def description_format string
    if string.length > 200
      string[0..200].split[0..-2].join(' ') + " ..."
    else
      string
    end
  end
  
  def title_remove_domain title
    website_prefixes = [" - ", " : ", " | "]
    website_prefixes.each do |i|
      if title.include?(i)
        title_cutoff = title.index(i)
        title = title[0..title_cutoff - 1]
      end
    end
    title
  end
  
  def title_format title
    title = title_remove_domain title
    if title.length > 65
      ((title[0..65].split)[0..-2]).join(" ") + " ..."
    else
      title
    end
  end
  
  def ensure_title_format
    if self.display_title.length > 65
      self.display_title = title_format self.display_title
    end
  end
  
  def ensure_description_format
    if self.description.length > 200
      self.description = description_format self.description
    end
  end
  
end
