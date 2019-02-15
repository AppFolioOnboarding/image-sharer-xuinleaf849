require 'test_helper'

class ImageControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_response :ok
    assert_select 'form', count: 1
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { url: 'https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg?cache=sixpwrbb1s&ops=1910_1000' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(@Image.last)
    assert_equal 'Image was successfully created.', flash[:notice]
  end

  def test_create__fail

  end

  def test_show
    image = Image.first
    get image_path(image)
    assert_response :ok
    assert_select '
  end

end
