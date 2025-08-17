# frozen_string_literal: true

class MediaItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_item, only: %i[ show edit update destroy increment_chapter decrement_chapter favorite unfavorite ]
  before_action :load_categories, only: [ :new, :edit, :create, :update ]

  def index
    @page_title = "My Collection"
    @categories = Category.all.order(:name)
    @tags = Tag.joins(:media_items).where(media_items: { user_id: current_user.id }).distinct.order(:name)

    items = current_user.media_items.includes(:tags, :category)
    items = apply_filters_and_sorting(items)

    @pagy, @media_items = pagy(items)
  end

  def favorites
    @page_title = "My Favorites"
    @categories = Category.all.order(:name)

    # CORRECTED: This is a more robust query to get the tags for your favorited items.
    @tags = Tag.joins(media_items: :favorites).where(favorites: { user_id: current_user.id }).distinct.order(:name)

    items = current_user.favorited_items
    items = apply_filters_and_sorting(items, favorites_order: true)

    @pagy, @media_items = pagy(items)
    render :favorites
  end

  # --- CREATE, UPDATE, DESTROY, SHOW, NEW, EDIT ---
  # These actions remain the same. They are standard and work correctly.
  def show; end
  def new; @media_item = MediaItem.new; end
  def edit; end

  def create
    @media_item = current_user.media_items.build(media_item_params)
    if @media_item.save
      # Add this line to check for new achievements
      AchievementService.check_achievements(current_user)
      redirect_to @media_item, notice: "Media item was successfully created."
    else
      @categories = Category.all.order(:name) # Reload categories for form
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @media_item.update(media_item_params)
      # Add this line to check for new achievements
      AchievementService.check_achievements(current_user)
      redirect_to @media_item, notice: "Media item was successfully updated."
    else
      @categories = Category.all.order(:name) # Reload categories for form
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @media_item.destroy!
    redirect_to media_items_path, notice: "Media item was successfully destroyed.", status: :see_other
  end

  # --- INSTANT UPDATE ACTIONS ---
  def increment_chapter
    # Use to_i to safely handle nil values, treating them as 0 for media items controller test
    @media_item.increment!(:chapters_read) if @media_item.chapters_read.to_i < @media_item.total_chapters.to_i
    render_card_update
  end

  def decrement_chapter
    @media_item.decrement!(:chapters_read) if @media_item.chapters_read.to_i > 0
    render_card_update
  end

  # REASON FOR CHANGE: Using `redirect_back` is more robust than Turbo Streams for this action.
  # It preserves the page's full state (filters, sort order, pagination) correctly.
  def favorite
    current_user.favorites.create(media_item: @media_item)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    current_user.favorites.where(media_item: @media_item).destroy_all
    # The `unfavorite` action for the favorites page uses a different stream response.
    # We can keep this more advanced logic as it works well.
    if request.referrer == favorites_media_items_url
      render turbo_stream: turbo_stream.remove(@media_item)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    # REASON FOR CHANGE: This new private method contains all the filter and sort logic.
    # It's cleaner than the old helper and is used by both index and favorites.
    def apply_filters_and_sorting(scope, favorites_order: false)
      # Apply filters
      scope = scope.where(category_id: params[:category_id]) if params[:category_id].present?
      scope = scope.joins(:tags).where(tags: { name: params[:tag] }) if params[:tag].present?

      # Apply search
      scope = scope.search_by_all_content(params[:search]) if params[:search].present?

      # Apply sorting
      sort_order = case params[:sort]
      when "highest_rated"    then "media_items.rating DESC NULLS LAST"
      when "recently_updated" then "media_items.updated_at DESC"
      when "title_asc"        then "media_items.title ASC"
      when "title_desc"       then "media_items.title DESC"
      else
        # Default sort is different for favorites page vs. main collection
        favorites_order ? "favorites.created_at DESC" : "media_items.created_at DESC"
      end

      # If sorting by favorites, we must join that table
      scope = scope.joins(:favorites) if favorites_order

      scope.order(sort_order)
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
        :cover_image, :chapters_read, :total_chapters, :tag_list,
        :story_rating, :art_rating, :characters_rating
      )
    end

    # This helper renders the Turbo Stream to update a card after +/- is clicked
    def render_card_update
      # Determine which partial to render based on the request's view parameter
      partial_to_render = params[:view] == "list" ? "media_items/list_item" : "media_items/grid_item"
      render turbo_stream: turbo_stream.replace(@media_item, partial: partial_to_render, locals: { media_item: @media_item })
    end
end
