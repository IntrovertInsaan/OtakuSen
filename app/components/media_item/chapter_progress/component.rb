# frozen_string_literal: true

class MediaItem::ChapterProgress::Component < ViewComponent::Base
  attr_reader :media_item

  def initialize(media_item:)
    @media_item = media_item
  end

  # The progress percentage is now calculated here, not in the view
  def progress_percentage
    return 0 unless media_item.total_chapters.to_i > 0
    (media_item.chapters_read.to_f / media_item.total_chapters.to_f) * 100
  end

  def render?
    media_item.chapters_read.present?
  end
end
