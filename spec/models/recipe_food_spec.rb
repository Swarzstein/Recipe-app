require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it 'belongs to a recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with a quantity, recipe_id, and food_id' do
      recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 10, cooking_time: 20)
      food = Food.create(name: 'Food 1', measurement_unit: 'unit', price: 10)
      recipe_food = RecipeFood.new(quantity: 2, recipe_id: recipe.id, food_id: food.id)
      expect(recipe_food).to be_valid
    end

    it 'is invalid without a quantity' do
      recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 10, cooking_time: 20)
      food = Food.create(name: 'Food 1', measurement_unit: 'unit', price: 10)
      recipe_food = RecipeFood.new(quantity: nil, recipe_id: recipe.id, food_id: food.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:quantity]).to include("can't be blank")
    end

    it 'is invalid without a recipe_id' do
      food = Food.create(name: 'Food 1', measurement_unit: 'unit', price: 10)
      recipe_food = RecipeFood.new(quantity: 2, recipe_id: nil, food_id: food.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:recipe_id]).to include("can't be blank")
    end

    it 'is invalid without a food_id' do
      recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 10, cooking_time: 20)
      recipe_food = RecipeFood.new(quantity: 2, recipe_id: recipe.id, food_id: nil)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:food_id]).to include("can't be blank")
    end

    it 'is invalid with a negative quantity' do
      recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 10, cooking_time: 20)
      food = Food.create(name: 'Food 1', measurement_unit: 'unit', price: 10)
      recipe_food = RecipeFood.new(quantity: -1, recipe_id: recipe.id, food_id: food.id)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:quantity]).to include('must be greater than or equal to 0')
    end
  end
end
