require 'rails_helper'

RSpec.describe 'Shopping List', type: :request do
  describe 'GET /index' do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
    let(:recipe) do
      Recipe.create(name: 'Recipe 2', description: 'This is a test and does nothing else', cooking_time: '20',
                    preparation_time: '10', public: false, user_id: current_user.id)
    end
    let(:inventory) { Inventory.create(name: 'Inventory 1', user_id: current_user.id) }
    before do
      current_user.confirm
      sign_in current_user
    end

    it 'path has the expected structure' do
      expect(
        shopping_list_index_path(
          recipe_id: recipe.id,
          inventory_id: inventory.id
        )
      ).to eq("/shopping_list?inventory_id=#{inventory.id}&recipe_id=#{recipe.id}")
    end

    it 'returns http success' do
      get shopping_list_index_path(recipe_id: recipe.id, inventory_id: inventory.id)
      expect(response).to have_http_status(:success)
    end
  end
end
