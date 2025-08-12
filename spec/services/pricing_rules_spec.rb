require 'rails_helper'

RSpec.describe 'Pricing Rules' do
  let!(:gt) { Product.create!(code: 'GT', name: 'Green Tea', price_cents: 310) }
  let!(:st) { Product.create!(code: 'ST', name: 'Strawberries', price_cents: 500) }
  let!(:cf) { Product.create!(code: 'CF', name: 'Coffee', price_cents: 1150) }

  it 'bogo free charges correctly' do
    rule = PricingRules::BogoFree.new(sku: 'GT')
    expect(rule.apply(product: gt, count: 1)).to eq(310)
    expect(rule.apply(product: gt, count: 2)).to eq(310)
    expect(rule.apply(product: gt, count: 3)).to eq(620)
  end

  it 'bulk price applies when threshold reached' do
    rule = PricingRules::BulkPrice.new(sku: 'ST', threshold: 3, unit_price_cents: 450)
    expect(rule.apply(product: st, count: 2)).to eq(500 * 2)
    expect(rule.apply(product: st, count: 3)).to eq(450 * 3)
  end

  it 'fractional bulk computes unit price and total' do
    rule = PricingRules::BulkFractional.new(sku: 'CF', threshold: 3, numerator: 2, denominator: 3)
    expect(rule.apply(product: cf, count: 1)).to eq(1150)
    per_unit = ((1150 * 2.0 / 3).round)
    expect(rule.apply(product: cf, count: 3)).to eq(per_unit * 3)
  end
end