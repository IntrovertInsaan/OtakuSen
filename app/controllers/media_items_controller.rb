# frozen_string_literal: true

class MediaItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_item, only: %i[ show edit update destroy increment_chapter decrement_chapter favorite unfavorite ]
  before_action :load_categories, only: [ :new, :edit, :create, :update ]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path, alert: "You are not authorized to access this."
  end

  def index
    @page_title = "My Collection"
    @categories = Category.all.order(:name)
    @tags = Tag.joins(:media_items).where(media_items: { user_id: current_user.id }).distinct.order(:name)

    filtered_items = MediaItemQuery.new(current_user.media_items, params).call
    fresh_when(filtered_items)
    @pagy, @media_items = pagy(filtered_items)
  end

  def favorites
    @page_title = "My Favorites"
    @categories = Category.all.order(:name)
    @tags = Tag.joins(media_items: :favorites).where(favorites: { user_id: current_user.id }).distinct.order(:name)

    filtered_favorites = FavoriteItemQuery.new(current_user, params).call
    @pagy, @media_items = pagy(filtered_favorites)
    render :favorites
  end

  def show; end
  def new; @media_item = MediaItem.new; end
  def edit; end

  def create
    @media_item = current_user.media_items.build(media_item_params)
    if @media_item.save
      AchievementService.check_achievements(current_user)
      redirect_to @media_item, notice: "Media item was successfully created."
    else
      @categories = Category.all.order(:name)
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @media_item.update(media_item_params)
      AchievementService.check_achievements(current_user)
      redirect_to @media_item, notice: "Media item was successfully updated."
    else
      @categories = Category.all.order(:name)
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @media_item.destroy!
    redirect_to media_items_path, notice: "Media item was successfully destroyed.", status: :see_other
  end

  def increment_chapter
    @media_item.increment!(:chapters_read) if @media_item.chapters_read.to_i < @media_item.total_chapters.to_i
    render_card_update
  end

  def decrement_chapter
    @media_item.decrement!(:chapters_read) if @media_item.chapters_read.to_i > 0
    render_card_update
  end

  def favorite
    current_user.favorites.create(media_item: @media_item)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    current_user.favorites.where(media_item: @media_item).destroy_all
    if request.referrer == favorites_media_items_url
      render turbo_stream: turbo_stream.remove(@media_item)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def set_media_item
      @media_item = current_user.media_items.find(params[:id])
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

    def render_card_update
      partial_to_render = params[:view] == "list" ? "media_items/list_item" : "media_items/grid_item"
      render turbo_stream: turbo_stream.replace(@media_item, partial: partial_to_render, locals: { media_item: @media_item })
    end
end
