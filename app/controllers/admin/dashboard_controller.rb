class Admin::DashboardController < Admin::BaseController
  def index
    # We can add site-wide stats here
    @total_users = User.count
    @total_media_items = MediaItem.count
    @total_notes = Note.count
  end
end
