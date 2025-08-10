json.extract! media_item, :id, :title, :description, :status, :rating, :category_id, :created_at, :updated_at
json.url media_item_url(media_item, format: :json)
