# frozen_string_literal: true

# This is for adding categories.
puts "Creating Categories..."
categories = [
  "Manga", "Manhwa", "Manhua", "Light Novel", "Anime",
  "Movies", "TV Series", "Web Series", "Documentary", "Song", "Book"
]
categories.each do |cat_name|
  Category.find_or_create_by!(name: cat_name)
end
puts "Finished seeding categories!"
puts "Created #{Category.count} categories."


# This new code for adding achievements.
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
  ach.icon_name = "book-open" # You'll need a book-open.svg icon
end

puts "Finished seeding achievements."
