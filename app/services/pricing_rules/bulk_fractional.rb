module PricingRules
  class BulkFractional < BaseRule
    def initialize(sku:, threshold:, numerator:, denominator:)
      @sku = sku
      @threshold = threshold
      @numerator = numerator
      @denominator = denominator
    end

    def applicable_skus
      [@sku]
    end

    def apply(product:, count:)
      if count >= @threshold
        unit = ((product.price_cents * numerator).to_f / @denominator).round
      else
        unit = product.price_cents
      end

      unit * count
    end
  end
end
