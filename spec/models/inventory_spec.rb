require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user_one) do
    User.create name: 'Muhammed', email: 'muhammed@gmail.com', password: '123456', password_confirmation: '123456'
  end
  let!(:inventory_one) { Inventory.create name: 'Test Inventory', user_id: user_one.id }
  let!(:inventory_two) { Inventory.create name: 'Test Inventory 2', user_id: user_one.id }

  context 'when name is present' do
    it 'is valid' do
      expect(inventory_one).to be_valid
    end
  end

  context 'when name is not present' do
    it 'is not valid' do
      inventory_one.name = nil
      expect(inventory_one).to_not be_valid
    end
  end

  context 'when user_id is not present' do
    it 'is not valid' do
      inventory_one.user_id = nil
      expect(inventory_one).to_not be_valid
    end
  end
end
