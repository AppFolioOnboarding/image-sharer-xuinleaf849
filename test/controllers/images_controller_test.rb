require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_response :ok
  end

  def test_create__valid
    assert_difference('Image.count', 1) do
      image_params = { imagelink: 'https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg?cache=sixpwrbb1s&ops=1910_1000' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(@Image.last)
  end

  def test_create__invalid
    assert_no_difference('Image.count') do
      image_params = { imagelink: 'afdsgasd'}
      post images_path, params: { image: image_params}
    end

    assert_response :unprocessable_entity
    assert_equal 'Invalid URL. Please try again!', flash[:alert]
  end

  def test_show
    image = Image.first
    get image_path(image)
    assert_response :ok
    assert_select '.image-show', count: 1
  end

end
