class Image < ApplicationRecord
  validates :imagelink, presence: true
  validates :imagelink, url: true
end
