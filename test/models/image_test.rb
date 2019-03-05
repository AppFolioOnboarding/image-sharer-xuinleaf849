require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    image_valid = Image.new(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg', tag_list: 'foo') # rubocop:disable Metrics/LineLength
    assert_predicate image_valid, :valid?
  end

  def test_image__invalid_if_url_is_invalid
    image_invalid = Image.new(imagelink: 'adsfgg', tag_list: 'bar')
    assert_not_predicate image_invalid, :valid?
    assert_equal 'is not a valid URL', image_invalid.errors[:imagelink].first
  end

  def test_image__invalid_if_url_is_blank
    image_invalid2 = Image.new(imagelink: '', tag_list: 'bar')
    assert_not_predicate image_invalid2, :valid?
    assert_equal "can't be blank", image_invalid2.errors[:imagelink].first
  end

  def test_image__invalid_if_no_tag
    image_invalid3 = Image.new(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg')
    assert_not_predicate image_invalid3, :valid?
    assert_equal "can't be blank", image_invalid3.errors[:tag_list].first
  end

  def test_image__taggable
    image = Image.new
    image.tag_list.add('awesome', 'perfect')
    assert_equal image.tag_list, %w[awesome perfect]
    image.tag_list.remove('awesome')
    assert_equal image.tag_list, ['perfect']
  end
end
