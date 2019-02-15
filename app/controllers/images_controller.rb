class ImagesController < ApplicationController

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:imagelink))

    if @image.save
      redirect_to @image
    else
      flash[:alert] = 'Invalid URL. Please try again!'
      render :new
    end
  end

  def show
    @image_url = Image.find(params[:id]).imagelink
  end

end
