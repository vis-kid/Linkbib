class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.build(params[:link])
    if @link.valid?
      @link.save
      flash[:success] = "Added a link"
      redirect_to user_path(current_user)
    else
      render 'new'
      flash[:error] = "Link invalid"
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
