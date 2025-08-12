class Product < ApplicationRecord
  validates :code, :name, presence: true
  validates :price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def price
    price_cents.to_f / 100.0
  end

  def formatted_price
    format('%.2f', price)
  end
end
