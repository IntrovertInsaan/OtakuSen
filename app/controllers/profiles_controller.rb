# frozen_string_literal: true

class ProfilesController < ApplicationController
  # This before_action will run for both :show and :achievements,
  # finding the user and handling the "Not Found" error in one place.
  before_action :set_user

  def show
    @categories = Category.all.order(:name)
    
    items = @user.media_items
    items = items.where(category_id: params[:category_id]) if params[:category_id].present?
    
    @pagy, @media_items = pagy(items.order(created_at: :desc))
  end

  # This is the new action for the achievements page
  def achievements
    @achievements = @user.achievements.order('user_achievements.created_at DESC')
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render "profiles/not_found", status: :not_found
  end
end
