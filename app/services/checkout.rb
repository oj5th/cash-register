class Checkout
  attr_reader :rules, :scanned

  def initialize(rules: [])
    @rules = rules
    @scanned = []
  end

  def scan(code)
    @scanned << code
  end

  def total_cents
    counts = scanned.group_by(&:itself).transform_values(&:size)
    products = Product.where(code: counts.keys).index_by(&:code)

    counts.sum do |code, count|
      product = products[code]
      raise "Unknown product '#{code}'" unless product

      rule = rules.find { |r| r.applicable_skus.include?(code) }
      if rule
        rule.apply(product: product, count: count)
      else
        product.price_cents * count
      end
    end
  end

  def total
    total_cents.to_f / 100.0
  end

  def formatted_total
    format('%.2f', total)
  end
end
