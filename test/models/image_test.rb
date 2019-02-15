require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    image_valid = Image.new(imagelink: 'https://images.pexels.com/photos/33053/dog-young-dog-small-dog-maltese.jpg?cs=srgb&dl=animal-dog-maltese-33053.jpg&fm=jpg')
    assert_predicate image_valid, :valid?
  end

  def test_image__invalid_if_url_is_invalid
    image_invalid = Image.new(imagelink: 'adsfgg')
    assert_not_predicate image_invalid, :valid?
    assert_equal 'is not a valid URL', image_invalid.errors[:imagelink].first
  end

  def test_image__invalid_if_url_is_blank
    image_invalid2 = Image.new(imagelink: '')
    assert_not_predicate image_invalid2, :valid?
    assert_equal "can't be blank", image_invalid2.errors[:imagelink].first
  end

end
