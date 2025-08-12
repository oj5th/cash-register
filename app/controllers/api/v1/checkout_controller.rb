module Api
  module V1
    class CheckoutController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        items = Array(params[:items] || [])
        rules = pricing_rules

        checkout = Checkout.new(rules: rules)
        items.each { |i| checkout.scan(i) }

        render json: { total_cents: checkout.total_cents, total: checkout.formatted_total }
      rescue => e
        render json: { error: e.message, status: :unprocessable_entity }
      end

      private

      def pricing_rules
        [
          PricingRules::BogoFree.new(sku: 'GT'),
          PricingRules::BulkPrice.new(sku: 'ST', threshold: 3, unit_price_cents: 450),
          PricingRules::BulkFractional.new(sku: 'CF', threshold: 3, numerator: 2, denominator: 3)
        ]
      end
    end
  end
end
