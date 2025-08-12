module PricingRules
  class BaseRule
    def apply(product:, count:)
      product.price_cents * count
    end

    def applicable_skus
      []
    end
  end
end
