require 'rails_helper'

RSpec.describe Checkout do
  let!(:gt) { Product.create!(code: 'GT', name:'Green Tea', price_cents: 310) }
  let!(:st) { Product.create!(code: 'ST', name:'Strawberries', price_cents: 500) }
  let!(:cf) { Product.create!(code: 'CF', name:'Coffee', price_cents: 1150) }

  let(:rules) do
    [
      PricingRules::BogoFree.new(sku: 'GT'),
      PricingRules::BulkPrice.new(sku: 'ST', threshold: 3, unit_price_cents: 450),
      PricingRules::BulkFractional.new(sku: 'CF', threshold: 3, numerator: 2, denominator: 3)
    ]
  end

  subject(:co) { Checkout.new(rules: rules) }

  it 'calculates total for sample basket' do
    %w[GT ST GT ST CF].each { |c| co.scan(c)}
    expect(co.total_cents).to eq(310 + 1000 + 1150)
  end

  it 'applies bulk strawberry pricing' do
    3.times { co.scan('ST') }
    expect(co.total_cents).to eq(450 * 3)
  end

  it 'applies coffee fractional pricing' do
    3.times { co.scan('CF') }
    per_unit = ((1150 * 2.0 / 3).round)
    expect(co.total_cents).to eq(per_unit * 3)
  end
end