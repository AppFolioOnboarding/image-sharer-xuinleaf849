class Image < ApplicationRecord
  validates :imagelink, url: true
end
