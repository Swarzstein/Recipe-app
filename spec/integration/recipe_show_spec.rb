require 'rails_helper'

describe 'Recipe', type: :feature do
  let!(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
  let!(:recipe) do
    Recipe.create(name: 'Recipe 2', description: 'Steps go here...',
                  cooking_time: 15 * 60, preparation_time: 1 * 60,
                  public: false, user_id: current_user.id)
  end
  let!(:food1) { Food.create(name: 'Apple', measurement_unit: 'g', price: 5) }
  let!(:food2) { Food.create(name: 'Pineapple', measurement_unit: 'g', price: 1) }
  let!(:food3) { Food.create(name: 'Chicken breasts', measurement_unit: 'units', price: 2) }
  let!(:food4) { Food.create(name: 'Chicken wings', measurement_unit: 'units', price: 1) }
  let!(:recipe_food1) { RecipeFood.create(recipe_id: recipe.id, food_id: food1.id, quantity: 20) }
  let!(:recipe_food2) { RecipeFood.create(recipe_id: recipe.id, food_id: food2.id, quantity: 10) }
  let!(:recipe_food3) { RecipeFood.create(recipe_id: recipe.id, food_id: food3.id, quantity: 2) }
  let!(:inventory1) { Inventory.create name: 'Inventory 1', user_id: current_user.id }
  let!(:inventory2) { Inventory.create name: 'Inventory 2', user_id: current_user.id }
  
  ingredients = RecipeFood.includes(:food).where(recipe_id: @recipe.id)
  puts ingredients

  before :each do
    current_user.confirm
    sign_in current_user
    visit recipe_path(recipe)
  end

  scenario 'User can see recipe details' do
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Preparation time: 1 hour')
    expect(page).to have_content('Cooking time: 15 hours')
    expect(page).to have_content('Steps go here...')
    expect(page).to have_content('Create food')
  end

  scenario 'User can see recipe ingredients' do
    expect(page).to have_content('Apple')
    expect(page).to have_content('Pineapple')
    expect(page).to have_content('Chicken breast')
  end

  scenario 'User can see recipe ingredients quantities' do
    expect(page).to have_content('20 g')
    expect(page).to have_content('10 g')
    expect(page).to have_content('2 units')
  end

  scenario 'User can see recipe ingredients prices' do
    expect(page).to have_content('$100')
    expect(page).to have_content('$10')
    expect(page).to have_content('$4')
  end

  scenario 'When user clicks on "Create new food" should add the food to the add ingredient list' do
    fill_in 'name', with: 'Tomato'
    fill_in 'measurement_unit', with: 'g'
    fill_in 'price', with: 2
    click_button('Create food')
    visit recipe_path(recipe)
    expect(page).to have_content('Tomato')
  end

  scenario 'When user clicks on "Add ingredient" button, it adds the ingredient' do
    find('#food-selector').select('Chicken wings')
    fill_in 'Quantity', with: 5
    click_button('Add ingredient')
    expect(page).to have_content('Chicken wings')
  end

  scenario 'When user clicks on "Generate shopping list" button, the page displays a form to add inventory' do
    click_button('Generate shopping list')
    expect(page).to have_content('Generating Shopping List')
    expect(page).to have_content('-- Select inventory --')
    expect(page).to have_content('Generate')
  end

  scenario 'When user clicks on "Generate" button, it takes you to the Shopping list' do
    expect(page).to have_content('Generating Shopping List')
    click_button('Generate shopping list')
    find('#inventory-selector').select('Inventory 1')
    click_button('Generate')
    expect(page).to have_content('Shopping List')
  end

  scenario 'When user clicks remove ingredient, the ingredient is removed from the recipe' do
    expect(page).to have_content('Apple')
    expect(page).to have_content('Pineapple')
    expect(page).to have_content('Chicken breast')
    click_link('Remove', id: "remove-recipe-#{recipe_food1.id}")
    within '#ingredients-list' do
      expect(page).to_not have_content('Apple')
      expect(page).to have_content('Pineapple')
      expect(page).to have_content('Chicken breast')
    end
  end
end
