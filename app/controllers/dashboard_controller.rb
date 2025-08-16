# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    # @total_items = MediaItem.count

    # A hash of counts for each category, e.g., {"Manhwa"=>3, "Movie"=>1}
    # @items_by_category = Category.joins(:media_items).group("categories.name").count

    # A hash of counts for each status, e.g., {"In Progress"=>2, "Completed"=>2}
    # @items_by_status = MediaItem.group(:status).count

    @total_items = current_user.media_items.count
    @items_by_category = current_user.media_items.joins(:category).group("categories.name").count
    @items_by_status = current_user.media_items.group(:status).count
  end
end
