class Item < ApplicationRecord
  has_many :photos, dependent: :destroy
end
