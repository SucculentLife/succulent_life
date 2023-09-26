class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  has_many :order_details
  belongs_to :user

  validates :postal_code, presence: true, length: {is: 7}, numericality: true
  validates :address, presence: true
  validates :name, presence: true, length: {minimum: 2}
  validates :payment_method, presence: true

  enum status: {
    wait_payment: 0,
    confirm_payment: 1,
    making: 2,
    preparing_ship: 3,
    finish_prepare: 4
  }
end
