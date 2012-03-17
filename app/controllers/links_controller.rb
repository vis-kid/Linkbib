class LinksController < ApplicationController
  def new
    if user_signed_in?
      @link = Link.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
      @link = current_user.links.build(params[:link])
      if @link.valid?
        @link.save
        redirect_to user_path(current_user), :success => "Added a link"
      else
        render 'new'
        flash[:error] = "Link invalid"
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.delete
    redirect_to user_path(current_user)
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:success] = "Edited the link"
      redirect_to user_path(current_user)
    else
      render 'edit'
      flash[:error] = "Can't edit that way..."
    end
  end
end