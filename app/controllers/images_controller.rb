class ImagesController < ApplicationController
  def index
    @images = if params[:tag]
                @tag_flag = true
                Image.tagged_with(params[:tag]).order(created_at: :desc)
              else
                @tag_flag = false
                Image.order(created_at: :desc).all
              end
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:success] = 'You have successfully added an image.'
      redirect_to image_path(@image)
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
    @image_tag_list = Image.find(params[:id]).tag_list
    @image_url = Image.find(params[:id]).imagelink
  end

  def destroy
      image = Image.find(params[:id])
      image.destroy!
      flash[:success] = 'You have successfully deleted the image.'
      redirect_to(images_path)
  end

  private

  def image_params
    params.require(:image).permit(:imagelink, :tag_list)
  end

end
