class Food < ApplicationRecord
  has_many :inventory_food
  has_many :recipe_food

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
