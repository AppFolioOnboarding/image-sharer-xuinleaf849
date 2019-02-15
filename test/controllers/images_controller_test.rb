require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @image = Image.create!(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg')
  end

  def test_new
    get new_image_path
    assert_response :ok
  end


  def test_create__valid
    assert_difference('Image.count', 1) do
      image_params = { imagelink: 'https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg?cache=sixpwrbb1s&ops=1910_1000' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
  end


  def test_create__invalid
    assert_no_difference('Image.count') do
      image_params = { imagelink: 'afdsgasd'}
      post images_path, params: { image: image_params}
    end

    assert_equal 'Invalid URL. Please try again!', flash[:alert]
  end


  def test_show
    get image_path(@image.id)
    assert_response :ok
    assert_select '.image-show', count: 1
  end

end
