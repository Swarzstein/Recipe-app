require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }

    before do
      current_user.confirm
      sign_in current_user
    end

    it 'returns http success' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
    let(:recipe) do
      Recipe.create(name: 'Recipe 2', description: 'This is a test and does nothing else', cooking_time: '20',
                    preparation_time: '10', public: false, user_id: current_user.id)
    end

    before do
      current_user.confirm
      sign_in current_user
    end

    it 'returns http success' do
      get recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end
end
