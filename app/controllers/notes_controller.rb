class NotesController < ApplicationController
  # Add this line to make the dom_id helper available
  include ActionView::RecordIdentifier

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
      respond_to do |format|
        format.turbo_stream do
          # Re-fetch notes to include the new one
          @notes = @media_item.notes.order(created_at: :desc)
          render turbo_stream: [
            # Stream 1: Replace the notes list inside the modal
            turbo_stream.replace("notes_content", partial: "notes/notes_list", locals: { media_item: @media_item, notes: @notes }),
            # Stream 2: Replace the notes section on the show page to update the badge
            turbo_stream.replace(dom_id(@media_item, :notes_section), partial: "media_items/notes_section", locals: { media_item: @media_item })
          ]
        end
      end
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
      # After update, just redirect back to the notes list inside the modal
      redirect_to media_item_notes_path(@media_item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note = @media_item.notes.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.turbo_stream do
        @notes = @media_item.notes.order(created_at: :desc)
        render turbo_stream: [
          turbo_stream.replace("notes_content", partial: "notes/notes_list", locals: { media_item: @media_item, notes: @notes }),
          turbo_stream.replace(dom_id(@media_item, :notes_section), partial: "media_items/notes_section", locals: { media_item: @media_item })
        ]
      end
    end
  end

  private

  def set_media_item
    @media_item = current_user.media_items.find(params[:media_item_id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
