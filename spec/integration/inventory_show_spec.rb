require 'rails_helper'

describe 'inventory_show', type: :feature do
  let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
  let(:inventory) { Inventory.create(name: 'Inventory 1', user_id: current_user.id) }
  let(:food1) { Food.create(name: 'Apple', measurement_unit: 'grams', price: 5) }
  let(:food2) { Food.create(name: 'Pineapple', measurement_unit: 'grams', price: 1) }
  let(:food3) { Food.create(name: 'Chicken breasts', measurement_unit: 'units', price: 2) }
  let(:inventory_food1) { InventoryFood.create(inventory_id: inventory.id, food_id: food1.id, quantity: 20) }
  let(:inventory_food2) { InventoryFood.create(inventory_id: inventory.id, food_id: food2.id, quantity: 7) }
  let(:inventory_food3) { InventoryFood.create(inventory_id: inventory.id, food_id: food2.id, quantity: 25) }

  before do
    current_user.confirm
    sign_in current_user
    visit inventory_path(inventory)
  end

  scenario 'User can see Inventory details' do
    expect(page).to have_content('Inventory 1')
  end

  scenario 'User can see Inventory food' do
    expect(page).to have_content('Apple')
    expect(page).to have_content('Pineapple')
    expect(page).to have_content('Chicken breasts')
  end

  # scenario "User can see Inventory's food" do
  #   expect(page).to have_content('Apple')
  #   expect(page).to have_content('Pineapple')
  #   expect(page).to have_content('Chicken breast')
  # end

  # scenario 'User can see recipe ingredients quantities' do
  #   expect(page).to have_content('10 grams')
  #   expect(page).to have_content('7 grams')
  #   expect(page).to have_content('25 units')
  # end

  # scenario 'When user clicks on "Add food" button, the page displays a form to add the ingredient' do
  #   click_button('Add ingredient')
  #   expect(page).to have_content('Select food')
  # end

  # scenario 'When user clicks remove on a food, the food is removed from the Inventory' do
  #   expect(page).to have_content('Apple')
  #   expect(page).to have_content('Pineapple')
  #   expect(page).to have_content('Chicken breast')
  #   click_button('Remove', id: "remove-inventory-#{recipe_food1.name}")
  #   expect(page).to_not have_content('Apple')
  #   expect(page).to have_content('Pineapple')
  #   expect(page).to have_content('Chicken breast')
  # end
end
