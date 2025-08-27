# frozen_string_literal: true

class MediaItem::Header::Component < ApplicationComponent
  attr_reader :media_item

  def initialize(media_item:)
    @media_item = media_item
  end
end
