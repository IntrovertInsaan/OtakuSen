class ExploreController < ApplicationController
  def index
    @categories = Category.all.order(:name)

    @media_items = MediaItem.all

    if params[:category_id].present?
      @media_items = @media_items.where(category_id: params[:category_id])
    end

    if params[:search].present?
      @media_items = @media_items.search_by_title_and_description(params[:search])
    end

    @media_items = @media_items.order(created_at: :desc)
  end
end
