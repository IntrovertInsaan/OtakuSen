# frozen_string_literal: true

FactoryBot.define do
  factory :achievement do
    sequence(:name) { |n| "achievement_#{n}" }
    display_name { "Test Achievement" }
    description { "A test description." }
    icon_name { "star" }
  end
end
