module PricingRules
  class BulkPrice < BaseRule
    def initialize(sku:, threshold:, unit_price_cents:)
      @sku = sku
      @threshold = threshold
      @unit_price_cents = unit_price_cents
    end

    def applicable_skus
      [@sku]
    end

    def apply(product:, count:)
      unit = count >= @threshold ? @unit_price_cents : product.price_cents
      unit * count
    end
  end
end
