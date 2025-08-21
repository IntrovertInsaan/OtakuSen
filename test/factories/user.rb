# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # Use a sequence to ensure every email and username is unique
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    # A "trait" is a modifier that lets you create variations of a factory.
    # In this case, it creates an admin user.
    trait :admin do
      admin { true }
    end
  end
end
