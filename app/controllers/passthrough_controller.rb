class PassthroughController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to home_path
    end
  end
end
