# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_media_item

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to media_item_path(@media_item), alert: "You are not authorized to access this."
  end

  def index
    @notes = @media_item.notes.order(created_at: :desc)
  end

  def new
    @note = @media_item.notes.new
  end

  def create
    @note = @media_item.notes.new(note_params)
    if @note.save
      respond_to do |format|
        format.turbo_stream do
          @notes = @media_item.notes.order(created_at: :desc)
          render turbo_stream: [
            turbo_stream.replace("notes_content_#{dom_id(@media_item)}", partial: "notes/notes_list", locals: { media_item: @media_item, notes: @notes }),
            turbo_stream.replace(dom_id(@media_item, :notes_section), MediaItem::NotesIcon::Component.new(media_item: @media_item))
          ]
        end

        format.html { redirect_to media_item_notes_path(@media_item), notice: "Note created successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_content }
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    @note = @media_item.notes.find(params[:id])
  end

  def update
    @note = @media_item.notes.find(params[:id])
    if @note.update(note_params)
      redirect_to media_item_notes_path(@media_item)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @note = @media_item.notes.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.turbo_stream do
        @notes = @media_item.notes.order(created_at: :desc)
        render turbo_stream: [
          turbo_stream.replace("notes_content_#{dom_id(@media_item)}", partial: "notes/notes_list", locals: { media_item: @media_item, notes: @notes }),
          turbo_stream.replace(dom_id(@media_item, :notes_section), MediaItem::NotesIcon::Component.new(media_item: @media_item))
        ]
      end

      format.html { redirect_to media_item_notes_path(@media_item), notice: "Note deleted successfully." }
    end
  end

  private

  def set_media_item
    @media_item = current_user.media_items.find_by(id: params[:media_item_id])
    redirect_to root_url, alert: "Not authorized" unless @media_item
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
