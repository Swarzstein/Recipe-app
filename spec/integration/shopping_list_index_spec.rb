require 'rails_helper'

describe 'Shopping List', type: :feature do
  before :each do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
    current_user.confirm
    sign_in current_user
    let(:recipe) {Recipe.create(name: 'Recipe 2', description: 'This is a test and does nothing else', cooking_time: "20", preparation_time: "10", public: false, user_id: current_user.id)}
    let(:inventory) { Inventory.create(name: 'Inventory 1', user_id: current_user.id) }
    let(:food1) {Food.new(name: "Apple", measurement_unit: "grams", price: 5)}
    let(:food2) {Food.new(name: "Pineapple", measurement_unit: "grams", price: 1)}
    let(:food3) {Food.new(name: "Banana", measurement_unit: "grams", price: 2)}
    let(:inventory_food1) {InventoryFood.create(inventory_id: inventory.id, food_id: food1.id, quantity: 240)}
    let(:inventory_food2) {InventoryFood.create(inventory_id: inventory.id, food_id: food2.id, quantity: 497)}
    let(:inventory_food3) {InventoryFood.create(inventory_id: inventory.id, food_id: food3.id, quantity: 1000)}
    let(:recipe_food1) {RecipeFood.create(recipe_id: recipe.id, food_id: food1.id, quantity: 250)}
    let(:recipe_food2) {RecipeFood.create(recipe_id: recipe.id, food_id: food2.id, quantity: 500)}
    let(:recipe_food3) {RecipeFood.create(recipe_id: recipe.id, food_id: food3.id, quantity: 250)}
    visit shopping_list_index_path(recipe_id: recipe.id, inventory_id: inventory.id)
  end

  it 'should show the shopping list' do
    expect(page).to have_content('Shopping List')
  end

  it 'should show the recipe name' do
    expect(page).to have_content(recipe.name)
  end

  it 'should show the inventory name' do
    expect(page).to have_content(inventory.name)
  end

  it 'should show the amount of food to buy' do
    expect(page).to have_content('Amount of food to buy: 2')
  end

  it 'should show the total price' do
    expect(page).to have_content('Total value of food needed: $53')
  end

  it 'should show the food name' do
    expect(page).to have_content(food1.name)
    expect(page).to have_content(food2.name)
    expect(page).not_to have_content(food3.name)
  end

  it 'should show the food quantity' do
    expect(page).to have_content('10 grams')
    expect(page).to have_content('3 grams')
  end

  it 'should show the food price' do
    expect(page).to have_content('$50')
    expect(page).to have_content('$3')
  end
end

