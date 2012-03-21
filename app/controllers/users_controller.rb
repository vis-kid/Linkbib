class UsersController < ApplicationController
  def feed
    @user = User.find(params[:id])
    @followers = @user.followers
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def following
    @followers = User.find(params[:id]).followers
  end
  
end
