class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true, length: {in: 1..10}
end
