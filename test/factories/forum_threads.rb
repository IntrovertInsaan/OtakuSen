# frozen_string_literal: true

FactoryBot.define do
  factory :forum_thread do
    title { "A Test Thread Title" }
    association :user
  end
end
