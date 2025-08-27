# frozen_string_literal: true

class MediaItem::DetailedRatings::Component < ViewComponent::Base
  attr_reader :media_item

  def initialize(media_item:)
    @media_item = media_item
  end

  # This component will only render if there are any detailed ratings to show
  def render?
    media_item.story_rating.present? || media_item.art_rating.present? || media_item.characters_rating.present?
  end
end
