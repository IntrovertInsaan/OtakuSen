# frozen_string_literal: true

# This is the definitive list of categories that should exist.
puts "Synchronizing Categories..."
expected_categories = [
  "Anime", "Books", "Cartoons", "Games", "Manga", "Manhwa", "Manhua", "Light Novel",
  "Movies", "Web Series", "Documentary", "Songs"
]

# Create any categories from the list that are missing.
expected_categories.each do |cat_name|
  Category.find_or_create_by!(name: cat_name)
end

# IMPORTANT: This line deletes any categories that are NOT in the list above.
Category.where.not(name: expected_categories).destroy_all

puts "Finished synchronizing categories!"
puts "There are now #{Category.count} categories."


# This section for achievements is already perfect.
puts "Seeding Achievements..."

Achievement.find_or_create_by!(name: "first_step") do |ach|
  ach.display_name = "First Step"
  ach.description = "Added your first media item to a collection."
  ach.icon_name = "plus-circle"
end

Achievement.find_or_create_by!(name: "collector") do |ach|
  ach.display_name = "Collector"
  ach.description = "Added 10 media items to your collection."
  ach.icon_name = "rectangle-stack"
end

Achievement.find_or_create_by!(name: "critic") do |ach|
  ach.display_name = "Critic"
  ach.description = "Rated 5 different items."
  ach.icon_name = "star"
end

Achievement.find_or_create_by!(name: "manhwa_maniac") do |ach|
  ach.display_name = "Manhwa Maniac"
  ach.description = "Added 5 or more Manhwa to your collection."
  ach.icon_name = "book-open"
end

puts "Finished seeding achievements."
