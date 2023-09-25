class Item < ApplicationRecord
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  validates :name, presence: true
  validates :introduction, presence: true, length: {in: 2..50}
  validates :price, presence: true, numericality: {only_integer: true}

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def with_tax_price
     (price * 1.1).floor
  end
end
