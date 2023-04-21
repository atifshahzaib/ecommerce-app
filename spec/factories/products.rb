# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph_by_chars(number: 250) }
    price { Faker::Commerce.price(range: 10..100.0, as_string: false) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    user
  end
end
