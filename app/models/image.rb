class Image < ApplicationRecord
  validates :imagelink, presence: true
  validates :imagelink, url: true
  acts_as_taggable
end
