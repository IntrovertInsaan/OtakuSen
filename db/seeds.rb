puts "Destroying existing MediaItems and Categories..."
MediaItem.destroy_all
Category.destroy_all

puts "Creating Categories..."

categories = [
  "Manga", "Manhwa", "Manhua", "Light Novel", "Web Novel", "Anime",
  "Movies", "TV Series", "Web Series", "Documentary", "Song"
]

categories.each do |cat_name|
  Category.find_or_create_by!(name: cat_name)
end

puts "Finished seeding categories!"
puts "Created #{Category.count} categories."
