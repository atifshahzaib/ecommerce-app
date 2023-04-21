# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    price { Faker::Commerce.price(range: 10..100.0, as_string: false) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    order
    product
  end
end
