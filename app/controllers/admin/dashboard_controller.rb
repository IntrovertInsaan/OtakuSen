# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    # Stats for the top cards
    @total_users = User.count
    @total_media_items = MediaItem.count
    @total_notes = ActionText::RichText.count # Correct way to count Action Text records

    # Data for the new tables, with pagination
    @pagy_users, @users = pagy(User.order(created_at: :desc), items: 10, page_param: :users_page)
    @pagy_media_items, @media_items = pagy(MediaItem.includes(:user, :category).order(created_at: :desc), items: 10, page_param: :media_items_page)
  end
end
