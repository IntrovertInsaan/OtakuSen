# frozen_string_literal: true

class MediaItem::ActionBar::Component < ViewComponent::Base
  attr_reader :media_item

  def initialize(media_item:)
    @media_item = media_item
  end
end
