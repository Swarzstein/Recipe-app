require 'rails_helper'

RSpec.describe 'Inventory', type: :system do
  let!(:current_user) { User.create name: 'Muhammed', email: 'muhammed@gmail.com', password: '123456' }
  let!(:inventory_one) { Inventory.create name: 'Test Inventory 1', user_id: current_user.id }
  let!(:inventory_two) { Inventory.create name: 'Test Inventory 2', user_id: current_user.id }
  let!(:food_one) { Food.create name: 'Salt', measurement_unit: 'kg', price: 5 }
  let!(:food_two) { Food.create name: 'Tomato', measurement_unit: 'kg', price: 5 }
  let!(:food_three) { Food.create name: 'Potato', measurement_unit: 'kg', price: 5 }
  let!(:food_four) { Food.create name: 'Carrot', measurement_unit: 'kg', price: 5 }
  let!(:food_five) { Food.create name: 'Banana', measurement_unit: 'kg', price: 5 }
  let!(:inventory_food_one) { InventoryFood.create inventory_id: inventory_one.id, food_id: food_one.id, quantity: 5 }
  let!(:inventory_food_two) { InventoryFood.create inventory_id: inventory_one.id, food_id: food_two.id, quantity: 5 }
  let!(:inventory_food_three) do
    InventoryFood.create inventory_id: inventory_one.id, food_id: food_three.id, quantity: 5
  end
  let!(:inventory_food_four) do
    InventoryFood.create inventory_id: inventory_two.id, food_id: food_four.id, quantity: 5
  end
  let!(:inventory_food_five) do
    InventoryFood.create inventory_id: inventory_two.id, food_id: food_five.id, quantity: 5
  end

  before do
    current_user.confirm
    sign_in current_user
  end

  it 'shows all inventories' do
    visit inventories_path
    expect(page).to have_content('Test Inventory 1')
    expect(page).to have_content('Test Inventory 2')
  end

  it 'when clicked on an inventory, it shows that inventory\'s information' do
    visit inventories_path
    click_link('Test Inventory 1')
    expect(page).to have_content('Test Inventory 1')
  end

  it 'should remove the inventory' do
    visit inventories_path
    within "#inventory-#{inventory_one.id}" do
      click_link('Remove')
    end
    expect(page).not_to have_content(inventory_one.name)
    expect(page).to have_content(inventory_two.name)
  end
end
