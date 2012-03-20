class UsersController < ApplicationController
  def feed
    @user = User.find(params[:id])
    @followers = @user.followers
    @links = []
    
    @followers.each do |follower|
      follower.links.each do |link|
        @links << link
      end
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def following
    @followers = User.find(params[:id]).followers
  end
  
end
