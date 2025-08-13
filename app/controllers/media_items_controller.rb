class MediaItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_media_item, only: %i[ show edit update destroy increment_chapter decrement_chapter ]
  before_action :load_categories, only: %i[ new create edit update ]

  # GET /media_items or /media_items.json
  def index
    @categories = Category.all.order(:name)
    @media_items = current_user.media_items

    if params[:category_id].present?
      @media_items = @media_items.where(category_id: params[:category_id])
    end

    # For Filtering in SEARCH
    if params[:search].present?
      @media_items = @media_items.search_by_title_and_description(params[:search])
    end

    @pagy, @media_items = pagy(@media_items.order(created_at: :desc))
  end

  # GET /media_items/1 or /media_items/1.json
  def show
  end

  # GET /media_items/new
  def new
    @media_item = MediaItem.new
  end

  # GET /media_items/1/edit
  def edit
  end

  # POST /media_items or /media_items.json
  def create
    @media_item = current_user.media_items.build(media_item_params)
    # @media_item = MediaItem.new(media_item_params)

    respond_to do |format|
      if @media_item.save
        format.html { redirect_to @media_item, notice: "Media item was successfully created." }
        format.json { render :show, status: :created, location: @media_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @media_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_items/1 or /media_items/1.json
  def update
    respond_to do |format|
      if @media_item.update(media_item_params)
        format.html { redirect_to @media_item, notice: "Media item was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @media_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @media_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_items/1 or /media_items/1.json
  def destroy
    @media_item.destroy!

    respond_to do |format|
      format.html { redirect_to media_items_path, notice: "Media item was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def increment_chapter
    @media_item.increment!(:chapters_read)
    render turbo_stream: turbo_stream.replace(@media_item)
  end

  def decrement_chapter
    @media_item.decrement!(:chapters_read)
    render turbo_stream: turbo_stream.replace(@media_item)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_item
      @media_item = MediaItem.find(params.expect(:id))
    end

    def load_categories
      @categories = Category.all.order(:name)
    end

    # Only allow a list of trusted parameters through.
    def media_item_params
      params.require(:media_item).permit(
        :title,
        :description,
        :status,
        :rating,
        :category_id,
        :cover_image,
        :chapters_read,
        :total_chapters,
        :tag_list
      )
    end
end
