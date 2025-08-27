# frozen_string_literal: true

json.id @media_item.id
json.title @media_item.title
json.description @media_item.description
json.status @media_item.status
json.rating @media_item.rating
json.category @media_item.category.name
json.tags @media_item.tags.pluck(:name)
json.created_at @media_item.created_at
