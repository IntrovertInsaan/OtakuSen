# frozen_string_literal: true

FactoryBot.define do
  factory :media_item do
    # Use Faker to generate a random book title
    title { Faker::Book.title }
    # Use Faker to generate a random paragraph for the description
    description { Faker::Lorem.paragraph }
    # Pick a random status from the list
    status { [ "Planning", "In Progress", "Completed" ].sample }
    # Generate a random rating between 1 and 10
    rating { rand(1..10) }

    # Associations remain the same
    association :user
    association :category
  end
end
