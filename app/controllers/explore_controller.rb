class ExploreController < ApplicationController
  def index
    @categories = Category.all.order(:name)

    all_items = MediaItem.all

    if params[:category_id].present?
      all_items = all_items.where(category_id: params[:category_id])
    end
    if params[:search].present?
      all_items = all_items.search_by_title_and_description(params[:search])
    end

    @pagy, @media_items = pagy(all_items.order(created_at: :desc))
  end
end
