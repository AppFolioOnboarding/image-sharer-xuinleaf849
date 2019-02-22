class ImagesController < ApplicationController
  def index
    if params[:tag]
      image_associate_to_tag = Image.tagged_with(params[:tag])
      flash[:notice] = 'No images associate with this tag!' if image_associate_to_tag.empty?
      @images = image_associate_to_tag.order('created_at DESC')
    else
      @images = Image.all.order('created_at DESC')
    end
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
      flash[:notice] = 'Invalid URL. Please try again!'
      render :new
    end
  end

  def show
    @image_tag_list = Image.find(params[:id]).tag_list
    @image_url = Image.find(params[:id]).imagelink
  end

  private

  def image_params
    params.require(:image).permit(:imagelink, :tag_list)
  end
end
