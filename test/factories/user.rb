# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # Use a sequence to ensure every email and username is unique
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
  end
end
