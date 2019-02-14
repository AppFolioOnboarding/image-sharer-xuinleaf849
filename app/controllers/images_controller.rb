class ImagesController < ApplicationController

  # def index
  # end


  def new
    @image = Image.new
  end


  def create
    @image = Image.new(params.require(:image).permit(:url))

    if @image.save
      redirect_to image_path(@image)
    else
      render :new
    end
  end

  def show
    @image_url = Image.find(params[:id]).url
  end

end
