class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to links_path, :notice => "Added a link"
    else
      render 'new'
    end
  end

  def index
  end
end
