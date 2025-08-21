# frozen_string_literal: true

FactoryBot.define do
  factory :tagging do
    association :media_item
    association :tag
  end
end
