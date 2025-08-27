# frozen_string_literal: true

class MediaItem::CoverImage::Component < ViewComponent::Base
  attr_reader :media_item, :variant

  def initialize(media_item:, variant: { resize_to_fill: [ 400, 600 ] })
    @media_item = media_item
    @variant = variant
  end
end
