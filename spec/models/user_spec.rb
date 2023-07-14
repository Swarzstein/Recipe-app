require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      user = User.new(name: 'John Doe', email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(name: nil, email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many recipes' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many inventories' do
      association = described_class.reflect_on_association(:inventory)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'devise modules' do
    it 'includes :database_authenticatable' do
      expect(described_class.devise_modules).to include(:database_authenticatable)
    end

    it 'includes :registerable' do
      expect(described_class.devise_modules).to include(:registerable)
    end

    it 'includes :recoverable' do
      expect(described_class.devise_modules).to include(:recoverable)
    end

    it 'includes :rememberable' do
      expect(described_class.devise_modules).to include(:rememberable)
    end

    it 'includes :validatable' do
      expect(described_class.devise_modules).to include(:validatable)
    end

    it 'includes :confirmable' do
      expect(described_class.devise_modules).to include(:confirmable)
    end
  end
end
