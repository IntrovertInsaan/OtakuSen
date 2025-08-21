# frozen_string_literal: true

FactoryBot.define do
  factory :forum_post do
    content { "This is a test post." }
    association :user
    association :forum_thread
  end
end
