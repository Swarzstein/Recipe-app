class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_food, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true
end
