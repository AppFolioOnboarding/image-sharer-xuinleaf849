class ImageController < ApplicationController
  def index
  end
  def new
    # @image = Image.new
  end

  def create
    render plain: params[:image].inspect
  end


end
