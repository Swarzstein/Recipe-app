require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { Food.new(name: 'carrot', measurement_unit: 'kg', price: 5) }

  before { subject.save }

  context 'when name is not present' do
    before { subject.name = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when measurement_unit is not present' do
    before { subject.measurement_unit = nil }

    it 'should not be valid' do
      expect(subject).to_not be_valid
    end
  end

  context 'when price is not present' do
    before { subject.price = nil }

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
