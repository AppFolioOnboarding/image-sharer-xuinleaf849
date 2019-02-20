class ImagesController < ApplicationController
  def index
    @images = Image.all.order('created_at DESC')
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

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

  private

  def image_params
    params.require(:image).permit(:imagelink, :tag_list)
  end
end
