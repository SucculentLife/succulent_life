class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true
  belongs_to :blog, optional: true

  validates :image, presence: true
end
