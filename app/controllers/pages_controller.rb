class PagesController < ApplicationController
  def home
    if user_signed_in?
      @feed = current_user.feed
      @link = current_user.links.build
    end
  end
end
