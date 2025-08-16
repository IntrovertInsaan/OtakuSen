class MediaItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_item, only: %i[ show edit update destroy increment_chapter decrement_chapter favorite unfavorite ]
  before_action :load_categories, only: %i[ new create edit update ]

  def index
    @page_title = "My Collection"
    @categories = Category.all.order(:name)
    @tags = Tag.joins(:media_items).where(media_items: { user_id: current_user.id }).distinct.order(:name)

    sort_order = case params[:sort]
    when "highest_rated"
      "media_items.rating DESC NULLS LAST"
    when "recently_updated"
      "media_items.updated_at DESC"
    when "title_asc"
      "media_items.title ASC"
    when "title_desc"
      "media_items.title DESC"
    else
      "media_items.created_at DESC"
    end

    base_items = current_user.media_items
    @pagy, @media_items = filter_and_paginate_items(base_items, sort_order)
  end

  def favorites
    @page_title = "My Favorites"
    @categories = Category.all.order(:name)

    # Corrected query to safely get tags from favorited items
    @tags = Tag.joins(media_items: :favorites).where(favorites: { user_id: current_user.id }).distinct.order(:name)

    items = current_user.favorited_items.includes(:tags)
    items = items.where(category_id: params[:category_id]) if params[:category_id].present?
    items = items.search_by_all_content(params[:search]) if params[:search].present?
    items = items.joins(:tags).where(tags: { name: params[:tag] }) if params[:tag].present?

    # Corrected query to join favorites table for ordering
    @pagy, @media_items = pagy(items.joins(:favorites).order("favorites.created_at DESC"))

    render :favorites
  end

  def show
  end

  def new
    @media_item = MediaItem.new
  end

  def edit
  end

  def create
    @media_item = current_user.media_items.build(media_item_params)
    if @media_item.save
      redirect_to @media_item, notice: "Media item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @media_item.update(media_item_params)
      redirect_to @media_item, notice: "Media item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @media_item.destroy!
    redirect_to media_items_path, notice: "Media item was successfully destroyed.", status: :see_other
  end

  def increment_chapter
    @media_item.increment!(:chapters_read) if @media_item.chapters_read < @media_item.total_chapters
    render turbo_stream: turbo_stream.replace(@media_item, partial: "media_items/grid_item", locals: { media_item: @media_item })
  end

  def decrement_chapter
    @media_item.decrement!(:chapters_read) if @media_item.chapters_read > 0
    render turbo_stream: turbo_stream.replace(@media_item, partial: "media_items/grid_item", locals: { media_item: @media_item })
  end

  def favorite
    current_user.favorites.create(media_item: @media_item)
    render turbo_stream: turbo_stream.replace(@media_item, partial: "media_items/grid_item", locals: { media_item: @media_item })
  end

  def unfavorite
    current_user.favorites.where(media_item: @media_item).destroy_all
    # This checks if the user was on the favorites page when they clicked the button.
    if request.referrer == favorites_media_items_url
      # If so, send a command to remove the item from the page.
      render turbo_stream: turbo_stream.remove(@media_item)
    else
      # Otherwise (if they were on the index, profile, etc.), just redraw the card.
      render turbo_stream: turbo_stream.replace(@media_item, partial: "media_items/grid_item", locals: { media_item: @media_item })
    end
  end

  private

    # This is the new helper method that contains all the filter logic
    def filter_and_paginate_items(items, order_by = "media_items.created_at DESC")
      items = items.includes(:tags)
      items = items.where(category_id: params[:category_id]) if params[:category_id].present?
      items = items.search_by_all_content(params[:search]) if params[:search].present?
      items = items.joins(:tags).where(tags: { name: params[:tag] }) if params[:tag].present?

      pagy(items.order(order_by))
    end

    def set_media_item
      @media_item = MediaItem.find(params[:id])
    end

    def load_categories
      @categories = Category.all.order(:name)
    end

    def media_item_params
      params.require(:media_item).permit(
        :title, :description, :status, :rating, :category_id,
        :cover_image, :chapters_read, :total_chapters, :tag_list
      )
    end
end
