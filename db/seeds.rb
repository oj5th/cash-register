# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.find_or_create_by!(code: 'GT') do |p|
  p.name = 'Green Tea'
  p.price_cents = 310
end

Product.find_or_create_by!(code: 'ST') do |p|
  p.name = 'Strawberries'
  p.price_cents = 500
end

Product.find_or_create_by!(code: 'CF') do |p|
  p.name = 'Coffee'
  p.price_cents = 1150
end
