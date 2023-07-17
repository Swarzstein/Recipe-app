require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }

    before do
      current_user.confirm
      sign_in current_user
    end

    it 'returns http success' do
      get inventories_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:current_user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
    let(:inventory) { Inventory.create(name: 'Inventory 1', user_id: current_user.id) }

    before do
      current_user.confirm
      sign_in current_user
    end

    it 'returns http success' do
      get inventory_path(inventory)
      expect(response).to have_http_status(:success)
    end
  end
end
