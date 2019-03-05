class Image < ApplicationRecord
  validates :imagelink, presence: true
  validates :imagelink, url: true
  validates :tag_list, presence: true
  acts_as_taggable_on :tags
end
