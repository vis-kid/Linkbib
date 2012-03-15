class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.build(params[:link])
    if @link.valid?
      @link.save
      flash[:success] = "Added a link"
      redirect_to links_path
    else
      render 'new'
      flash[:error] = "Link invalid"
    end
  end

  def index
  end
end
