require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    # it { should belong_to(:user) }
    # it { should have_many(:ingredients) }
    # it { should have_many(:steps) }
    # it { should have_many(:comments) }
    # it { should have_many(:ratings) }
  end
  let(:user) { User.create(name: 'Akai', email: 'akai123@gmail.com', password: '123456') }
  subject do
    Recipe.new(name: 'test', description: 'This is a test and does nothing else', cooking_time: '20',
               preparation_time: '10', public: false, user_id: user.id)
  end

  before { subject.save }

  context 'when name is not present' do
    before { subject.name = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when description is not present' do
    before { subject.description = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when cooking_time is not present' do
    before { subject.cooking_time = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when preparation_time is not present' do
    before { subject.preparation_time = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when everything is present' do
    it 'should be valid' do
      expect(subject).to be_valid
    end
  end
end
