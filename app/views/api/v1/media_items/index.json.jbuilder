json.array! @media_items do |media_item|
  json.id media_item.id
  json.title media_item.title
  json.category media_item.category.name
  json.url api_v1_media_item_url(media_item, format: :json)
end
