require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_index__images_in_desc_order
    images = [
      { imagelink: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: %w[appfolio logo] },
      { imagelink: 'https://pbs.twimg.com/profile_images/999418366858149888/zKQCw1Ok_400x400.jpg', tag_list: 'foo' },
      { imagelink: 'https://microsmallcap.com/wp-content/uploads/sites/2/2018/01/AppFolio-The-Dip-is-a-Buying-Opportunity-.png', tag_list: ['appfolio'] }  # rubocop:disable Metrics/LineLength
    ]
    Image.create(images.reverse)

    get images_path
    assert_response :ok
    assert_select 'h1', 'Images'

    assert_select '.js-image-link', 3
    assert_select '.js-image-link' do |image_elements|
      image_elements.each_with_index do |image_element, index|
        assert_select image_element, 'img[src=?]', images[index][:imagelink]
      end
    end
  end

  def test_index__tags_with_links
    images = [
      { imagelink: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png', tag_list: %w[appfolio logo] },
      { imagelink: 'https://pbs.twimg.com/profile_images/999418366858149888/zKQCw1Ok_400x400.jpg', tag_list: 'foo' },
      { imagelink: 'https://microsmallcap.com/wp-content/uploads/sites/2/2018/01/AppFolio-The-Dip-is-a-Buying-Opportunity-.png', tag_list: ['appfolio'] }  # rubocop:disable Metrics/LineLength
    ]
    Image.create(images.reverse)

    get images_path
    assert_response :ok

    assert_equal images[0][:tag_list], %w[appfolio logo]
    assert_equal images[2][:tag_list], ['appfolio']
    assert_select 'a[data-method=delete]', 3
  end

  def test_index__delete_succeed
    image = Image.create(imagelink: 'https://www.appfolio.com/images/html/apm-fb-logo.png',
                         tag_list: %w[appfolio company])

    assert_difference 'Image.count', -1 do
      delete image_path(image.id)
    end

    assert_redirected_to images_path
    assert_equal 'You have successfully deleted the image.', flash[:success]
    assert_select 'img', 0
  end

  def test_new
    get new_image_path
    assert_response :ok
    assert_select 'input#image_tag_list[name=?]', 'image[tag_list]'
  end

  def test_create__valid
    assert_difference('Image.count', 1) do
      image_params = { imagelink: 'https://i.vimeocdn.com/portrait/328672_300x300', tag_list: 'foo' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
  end

  def test_create__invalid_with_tags
    assert_no_difference('Image.count') do
      image_params = { imagelink: 'https://i.vimeocdn.com/portrait/328672_300x300' }
      post images_path, params: { image: image_params }
    end
  end

  def test_create__invalid_with_url
    assert_no_difference('Image.count') do
      image_params = { imagelink: 'afdsgasd', tag_list: 'foo' }
      post images_path, params: { image: image_params }
    end
  end
Ω
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

  def test_destroy
    image = Image.create!(imagelink: 'https://www.appfolio.com/images/html/apm-fb-logo.png',
                          tag_list: %w[appfolio company])

    assert_difference 'Image.count', -1 do
      delete image_path(image.id)
    end

    assert_redirected_to images_path
    assert_equal 'You have successfully deleted the image.', flash[:success]
  end
end
