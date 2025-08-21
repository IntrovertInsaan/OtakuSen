# frozen_string_literal: true

FactoryBot.define do
  factory :user_achievement do
    association :user
    association :achievement
  end
end
