class UsersController < ApplicationController
  def feed
    @user = User.find(params[:id])
    @followers = @user.followers
  end
  
  def show
    @user = User.find_by_name(params[:id])
    @link = current_user.links.build
    @current_user = current_user
  end
  
  def following
    @user = User.find_by_name(params[:id])
    @following = @user.followed_users
  end
  
  def followers
    @user = User.find_by_name(params[:id])
    @followers = @user.followers
  end
end
