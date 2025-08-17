class AchievementService
  def self.check_achievements(user)
    new(user).check_achievements
  end

  def initialize(user)
    @user = user
  end

  def check_achievements
    check_first_step
    check_collector
    check_critic
  end

  private

  def grant_achievement(name)
    achievement = Achievement.find_by(name: name)
    # Grant the achievement only if the user doesn't have it already
    UserAchievement.find_or_create_by(user: @user, achievement: achievement) if achievement
  end

  def check_first_step
    grant_achievement("First Step") if @user.media_items.count >= 1
  end

  def check_collector
    grant_achievement("Collector") if @user.media_items.count >= 10
  end

  def check_critic
    grant_achievement("Critic") if @user.media_items.where.not(rating: nil).count >= 5
  end
end
