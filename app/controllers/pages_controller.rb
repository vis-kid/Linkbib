class PagesController < ApplicationController
  def home
    if user_signed_in?
      @feed = current_user.feed
    end
  end
end
