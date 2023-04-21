# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    amount_paid { Faker::Commerce.price(range: 10..100.0, as_string: false) }
    user
  end
end
