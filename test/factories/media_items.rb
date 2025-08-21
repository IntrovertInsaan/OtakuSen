# frozen_string_literal: true

FactoryBot.define do
  factory :media_item do
    title { "Test Item" }
    status { "Planning" }
    association :user     # Automatically uses the :user factory
    association :category # Automatically uses the :category factory
  end
end
