# frozen_string_literal: true

namespace :achievements do
  desc "Check and grant achievements for all existing users"
  task check_all: :environment do
    puts "Checking achievements for all users..."
    User.find_each do |user|
      puts " - Checking #{user.email}..."
      AchievementService.check_achievements(user)
    end
    puts "Done."
  end
end
