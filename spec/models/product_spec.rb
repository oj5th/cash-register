require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = described_class.new(code: 'GT', name: 'Green Tea', price_cents: 310)
      expect(product).to be_valid
    end

    it 'is invalid without a code' do
      product = described_class.new(name: 'Green Tea', price_cents: 310)
      expect(product).not_to be_valid
      expect(product.errors[:code]).to include("can't be blank")
    end

    it 'is invalid without a name' do
      product = described_class.new(code: 'GT', price_cents: 310)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it 'is invalid if price_cents is negative' do
      product = described_class.new(code: 'GT', name: 'Green Tea', price_cents: -50)
      expect(product).not_to be_valid
      expect(product.errors[:price_cents]).to include('must be greater than or equal to 0')
    end

    it 'is invalid if price_cents is not an integer' do
      product = described_class.new(code: 'GT', name: 'Green Tea', price_cents: 3.5)
      expect(product).not_to be_valid
      expect(product.errors[:price_cents]).to include("must be an integer")
    end
  end

  describe '#price' do
    it 'returns the price in euros as a float' do
      product = described_class.new(price_cents: 310)
      expect(product.price).to eq(3.10)
    end
  end

  describe '#formatted_price' do
    it 'returns the price formatted with two decimals' do
      product = described_class.new(price_cents: 310)
      expect(product.formatted_price).to eq("3.10")
    end
  end
end
