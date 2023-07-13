require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user_one) { User.create name: 'Muhammed', email: 'muhammed@gmail.com', password: '123456' }
  let!(:food_one) { Food.create name: 'Test Food', price: 12, measurement_unit: 'kg' }
  let!(:inventory_one) { Inventory.create name: 'Test Inventory', user_id: user_one.id }
  let!(:inventory_food_one) do
    InventoryFood.create inventory_id: inventory_one.id, food_id: food_one.id, quantity: 1
  end

  context 'when quantity is present' do
    it 'is valid' do
      expect(inventory_food_one).to be_valid
    end
  end

  context 'when quantity is not present' do
    it 'is not valid' do
      inventory_food_one.quantity = nil
      expect(inventory_food_one).to_not be_valid
    end
  end

  context 'when quantity is less than 0' do
    it 'is not valid' do
      inventory_food_one.quantity = -1
      expect(inventory_food_one).to_not be_valid
    end
  end

  context 'when inventory_id is not present' do
    it 'is not valid' do
      inventory_food_one.inventory_id = nil
      expect(inventory_food_one).to_not be_valid
    end
  end

  context 'when food_id is not present' do
    it 'is not valid' do
      inventory_food_one.food_id = nil
      expect(inventory_food_one).to_not be_valid
    end
  end
end
