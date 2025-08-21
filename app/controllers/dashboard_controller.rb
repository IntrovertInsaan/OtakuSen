# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @total_items = current_user.media_items.count
    @items_by_category = current_user.media_items.joins(:category).group("categories.name").count
    @items_by_status = current_user.media_items.group(:status).count
  end
end
