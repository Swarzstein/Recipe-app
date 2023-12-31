require 'rails_helper'

describe 'User Index', type: :feature do
  let!(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
  let!(:user1) { User.create(name: 'User 1', email: 'user1@gmail.com', password: '123456') }
  let!(:user2) { User.create(name: 'User 2', email: 'user2@gmail.com', password: '123456') }
  let!(:user3) { User.create(name: 'User 3', email: 'user3@gmail.com', password: '123456') }
  let!(:recipe1) do
    Recipe.create(name: 'Recipe 1', description: 'This is recipe 1', cooking_time: 1, preparation_time: 2,
                  user_id: user1.id, public: true)
  end
  let!(:recipe2) do
    Recipe.create(name: 'Recipe 2', description: 'This is recipe 2', cooking_time: 1, preparation_time: 2,
                  user_id: user2.id, public: true)
  end
  let!(:recipe3) do
    Recipe.create(name: 'Recipe 3', description: 'This is recipe 3', cooking_time: 1, preparation_time: 2,
                  user_id: user3.id)
  end
  let!(:food1) { Food.create(name: 'Apple', measurement_unit: 'kg', price: 2) }
  let!(:food2) { Food.create(name: 'Orange', measurement_unit: 'kg', price: 3) }
  let!(:food3) { Food.create(name: 'Banana', measurement_unit: 'kg', price: 1) }
  let!(:food4) { Food.create(name: 'Melon', measurement_unit: 'kg', price: 2) }
  let!(:food5) { Food.create(name: 'Pineapple', measurement_unit: 'g', price: 1) }
  let!(:food6) { Food.create(name: 'Watermelon', measurement_unit: 'g', price: 5) }
  let!(:recipe_food1) { RecipeFood.create(recipe_id: recipe1.id, food_id: food1.id, quantity: 20) }
  let!(:recipe_food2) { RecipeFood.create(recipe_id: recipe1.id, food_id: food2.id, quantity: 10) }
  let!(:recipe_food3) { RecipeFood.create(recipe_id: recipe2.id, food_id: food3.id, quantity: 2) }
  let!(:recipe_food4) { RecipeFood.create(recipe_id: recipe2.id, food_id: food4.id, quantity: 2) }
  let!(:recipe_food5) { RecipeFood.create(recipe_id: recipe2.id, food_id: food5.id, quantity: 2) }
  let!(:recipe_food6) { RecipeFood.create(recipe_id: recipe3.id, food_id: food1.id, quantity: 2) }
  let!(:recipe_food7) { RecipeFood.create(recipe_id: recipe3.id, food_id: food2.id, quantity: 2) }
  let!(:recipe_food8) { RecipeFood.create(recipe_id: recipe3.id, food_id: food3.id, quantity: 2) }
  let!(:recipe_food9) { RecipeFood.create(recipe_id: recipe3.id, food_id: food4.id, quantity: 2) }
  let!(:recipe_food10) { RecipeFood.create(recipe_id: recipe3.id, food_id: food5.id, quantity: 2) }
  let!(:recipe_food11) { RecipeFood.create(recipe_id: recipe3.id, food_id: food6.id, quantity: 2) }

  before do
    current_user.confirm
    sign_in current_user
  end

  scenario 'User can see the name of the page' do
    visit users_path

    expect(page).to have_content('Public Recipes')
  end

  scenario 'User can see a list of all public recipes' do
    visit users_path

    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('Total food items: 2')
    expect(page).to have_content('Total price: $70')
    expect(page).to have_content('By: User 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Total food items: 3')
    expect(page).to have_content('Total price: $8')
    expect(page).to have_content('By: User 2')
    expect(page).not_to have_content('Recipe 3')
    expect(page).not_to have_content('Total food items: 6')
    expect(page).not_to have_content('Total price: $28')
    expect(page).not_to have_content('by: User 3')
  end

  scenario 'User can see public recipe details' do
    visit users_path
    click_link(id: "recipe-#{recipe1.id}")
    expect(page).to have_current_path(recipe_path(recipe1))
  end
end
