class ShoppingListController < ApplicationController
  def index
    @params = params
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    @foods_to_buy = calculate_foods_to_buy(@recipe, @inventory)
    @total_price = calculate_total_price(@foods_to_buy)
  end

  private

  def calculate_foods_to_buy(recipe, inventory)
    foods = []
    recipe.recipe_foods.each do |recipe_food|
      inventory_food = inventory.inventory_food.find_by(food_id: recipe_food.food_id)
      remaining_quantity = recipe_food.quantity - (inventory_food&.quantity || 0)
      next unless remaining_quantity.positive?

      foods << {
        name: recipe_food.food.name,
        quantity: remaining_quantity,
        price: recipe_food.food.price
      }
    end
    foods
  end

  def calculate_total_price(foods)
    total_price = 0
    foods.each do |food|
      total_price += food[:price] * food[:quantity]
    end
    total_price
  end
end
