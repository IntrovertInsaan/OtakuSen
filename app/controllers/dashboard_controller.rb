class DashboardController < ApplicationController
  def index
    @total_items = MediaItem.count

    # A hash of counts for each category, e.g., {"Manhwa"=>3, "Movie"=>1}
    @items_by_category = Category.joins(:media_items).group("categories.name").count

    # A hash of counts for each status, e.g., {"In Progress"=>2, "Completed"=>2}
    @items_by_status = MediaItem.group(:status).count
  end
end
