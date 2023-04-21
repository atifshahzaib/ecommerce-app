# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.zone.now }
  end
end
