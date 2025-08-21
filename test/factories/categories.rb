# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    # By default, it will create a generic category name
    sequence(:name) { |n| "Generic Category #{n}" }

    # A "trait" is a modifier that lets you create a specific version.
    trait :manhwa do
      name { "Manhwa" }
    end

    trait :movie do
      name { "Movie" }
    end
  end
end
