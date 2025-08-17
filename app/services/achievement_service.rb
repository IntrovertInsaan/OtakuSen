class AchievementService
  def self.check_achievements(user)
    new(user).check_all
  end

  def initialize(user)
    @user = user
    # Eager load the user's achievement IDs for efficiency
    @user_achievement_ids = @user.achievement_ids
  end

  def check_all
    check_first_step
    check_collector
    check_critic
    check_manhwa_maniac # 1. Add this line
  end

  private

  def grant_achievement(name)
    # Find the achievement by its stable, internal name
    achievement = Achievement.find_by(name: name)

    # Guard against missing achievements or if the user already has it
    return if achievement.nil? || @user_achievement_ids.include?(achievement.id)

    # Grant the new achievement using the safe ActiveRecord association method
    @user.achievements << achievement
  end

  def check_first_step
    grant_achievement("first_step") if @user.media_items.count >= 1
  end

  def check_collector
    grant_achievement("collector") if @user.media_items.count >= 10
  end

  def check_critic
    grant_achievement("critic") if @user.media_items.where.not(rating: nil).count >= 5
  end

  # 2. Add this new private method at the bottom
  def check_manhwa_maniac
    manhwa_category = Category.find_by(name: "Manhwa")
    return unless manhwa_category

    if @user.media_items.where(category: manhwa_category).count >= 5
      grant_achievement("manhwa_maniac")
    end
  end
end
