# frozen_string_literal: true

class FilterBarComponent < ViewComponent::Base
  def initialize(path:, categories:, tags:, current_params:)
    @path = path
    @categories = categories
    @tags = tags
    @current_params = current_params
  end
end
