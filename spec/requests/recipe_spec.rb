require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /index" do
    let(:current_user) { User.create(name: "Akai", email: "akai123@gmail.com", password: "123456") }
    
    before do
      current_user.confirm
      sign_in current_user
    end

    it "returns http success" do
      get recipes_path
      expect(response).to have_http_status(:success)
    end
  end
end
