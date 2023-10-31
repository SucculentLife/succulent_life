class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: {minimum: 2}
  validates :postal_code, presence: true, length: {is: 7}, numericality: true
  validates :address, presence: true

  def address_display
    '〒' + postal_code + '　' + address + '　' + name
  end
end
