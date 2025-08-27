class Api::V1::MediaItemsController < Api::BaseController
  def index
    @media_items = current_user.media_items.order(created_at: :desc)
  end

  def show
    @media_item = current_user.media_items.find(params[:id])
  end
end
