class User < ApplicationRecord
  has_many :recipe, dependent: :destroy
  has_many :inventory, dependent: :destroy

  validates :name, presence: true
end
