class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_food, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true

  def inventory_food
    self.inventory_food = InventoryFood.where(inventory_id: id)
  end
end
