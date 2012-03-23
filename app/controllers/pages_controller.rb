class PagesController < ApplicationController
  def home
    if user_signed_in?
      @feed = current_user.feed
      @link = current_user.links.build
      # @instapaper = "http://www.instapaper.com/api/add?username=benjohnstonsf@gmail.com&password=brucelee1&url=#{link.url}"
    end
  end
end


# @instapaper = "http://www.instapaper.com/api/add?username=benjohnstonsf@gmail.com&password=brucelee1&url=#{link.url}"
