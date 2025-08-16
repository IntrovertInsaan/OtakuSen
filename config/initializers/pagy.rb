# frozen_string_literal: true

# Pagy initializer for test-friendly settings
# This will make pagination in tests use 3 items per page for easy multi-page tests
require "pagy"

Pagy::DEFAULT[:items] = 3
