class Blog < ApplicationRecord
  has_many :blog_images, dependent: :destroy
  accepts_nested_attributes_for :blog_images, allow_destroy: true
  
  validates :title, presence: true
  validates :body, presence: true
end
