# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title { "Test Note" }
    content { "This is the content." }
    association :media_item
  end
end
