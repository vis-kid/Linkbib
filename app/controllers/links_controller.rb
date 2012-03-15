class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.build(params[:link])
    if @link.save
      redirect_to links_path, :notice => "Added a link"
    else
      render 'new'
    end
  end

  def index
  end
end
