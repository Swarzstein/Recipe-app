class Food < ApplicationRecord
  has_many :inventory_food, dependent: :destroy
  has_many :recipe_food, dependent: :destroy

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
