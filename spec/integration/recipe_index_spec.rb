require 'rails_helper'

describe 'Recipe Index', type: :feature do
  let!(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
  let!(:recipe1) do
    Recipe.create(name: 'Recipe 1', description: 'This is recipe 1', cooking_time: 1, preparation_time: 2,
                  user_id: current_user.id)
  end
  let!(:recipe2) do
    Recipe.create(name: 'Recipe 2', description: 'This is recipe 2', cooking_time: 1, preparation_time: 2,
                  user_id: current_user.id)
  end

  before do
    current_user.confirm
    sign_in current_user
  end

  scenario 'User can see a list of all recipes' do
    visit recipes_path

    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('This is recipe 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('This is recipe 2')
  end

  scenario 'User can remove a recipe from the list' do
    visit recipes_path

    within "#recipe-#{recipe1.id}" do
      expect(page).to have_content('Recipe 1')
      expect(page).to have_content('This is recipe 1')
      click_link('Remove')
    end

    expect(page).not_to have_content('Recipe 1')
    expect(page).not_to have_content('This is recipe 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('This is recipe 2')
  end

  scenario 'When user clicks a recipe, they are taken to the recipe page' do
    visit recipes_path

    click_link(id: "recipe-#{recipe1.id}")
    expect(page).to have_current_path(recipe_path(recipe1))
  end

  scenario 'When user clicks the "Add New Recipe" button' do
    visit recipes_path

    fill
    click_link('Add New Recipe')
    expect(page).to have_current_path(new_recipe_path)
  end
end
