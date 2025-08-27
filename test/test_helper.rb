# frozen_string_literal: true

require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Add this line to configure Devise for tests
Devise.mappings[:user]

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    include Devise::Test::IntegrationHelpers
    include FactoryBot::Syntax::Methods
  end
end
