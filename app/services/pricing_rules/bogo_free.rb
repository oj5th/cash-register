module PricingRules
  class BogoFree < BaseRule
    def initialize(sku:)
      @sku = sku
    end

    def applicable_skus
      [@sku]
    end

    # charge for half rounded up (pairs count as one paid unit)
    def apply(product:, count:)
      paid_units = (count / 2) + (count % 2)
      product.price_cents * paid_units
    end
  end
end