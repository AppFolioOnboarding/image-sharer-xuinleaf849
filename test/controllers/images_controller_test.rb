require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index
    images = [
      { imagelink: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: ['appfolio'] },
      { imagelink: 'https://pbs.twimg.com/profile_images/999418366858149888/zKQCw1Ok_400x400.jpg' }
    ]
    Image.create(images)

    get images_path
    assert_response :ok
    assert_select 'h1', 'Images'
    assert_select 'img', count: 2

    assert_select "li:last-child img[src='#{images[0][:imagelink]}']", count: 1
    assert_select 'li:last-child .tag_class', count: 1
    assert_select "li:first-child img[src='#{images[1][:imagelink]}']", count: 1
    assert_select 'li:first-child .tag_class', count: 0
  end

  def test_new
    get new_image_path
    assert_response :ok
  end

  def test_create__valid
    assert_difference('Image.count', 1) do
      image_params = { imagelink: 'https://i.vimeocdn.com/portrait/328672_300x300' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
  end

  def test_create__invalid
    assert_no_difference('Image.count') do
      image_params = { imagelink: 'afdsgasd' }
      post images_path, params: { image: image_params }
    end

    assert_equal 'Invalid URL. Please try again!', flash[:alert]
  end

  def test_show__image_found
    image_show = Image.create!(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg')
    get image_path(image_show.id)
    assert_response :ok
    assert_select '.image-show', count: 1
  end

  def test_show__tag_found
    image_tag = Image.create!(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg', tag_list: %w[dog adorable]) # rubocop:disable  Metrics/LineLength
    get image_path(image_tag.id)
    assert_response :ok
    assert_select 'li', count: 2
  end

  def test_show__no_tag
    image = Image.create!(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg', tag_list: []) # rubocop:disable  Metrics/LineLength
    get image_path(image.id)
    assert_response :ok
    assert_select 'li', count: 0
  end
end
