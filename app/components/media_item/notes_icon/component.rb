# frozen_string_literal: true

class MediaItem::NotesIcon::Component < ViewComponent::Base
  attr_reader :media_item

  def initialize(media_item:)
    @media_item = media_item
  end

  # This component should only render if the viewer is the owner of the item
  def render?
    helpers.user_signed_in? && helpers.current_user == media_item.user
  end
end
