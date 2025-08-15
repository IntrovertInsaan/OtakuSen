class NotesController < ApplicationController
  before_action :set_media_item

  def index
    @notes = @media_item.notes.order(created_at: :desc)
  end

  def new
    @note = @media_item.notes.new
  end

  def create
    @note = @media_item.notes.new(note_params)
    if @note.save
      redirect_to @media_item, notice: "Note created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = @media_item.notes.find(params[:id])
  end

  def update
    @note = @media_item.notes.find(params[:id])
    if @note.update(note_params)
      redirect_to @media_item, notice: "Note updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note = @media_item.notes.find(params[:id])
    @note.destroy
    redirect_to @media_item, notice: "Note deleted."
  end

  private

  def set_media_item
    @media_item = current_user.media_items.find(params[:media_item_id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
