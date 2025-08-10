class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @categories = Category.all.order(:name)
    @media_items = @user.media_items

    if params[:category_id].present?
      @media_items = @media_items.where(category_id: params[:category_id])
    end

    @media_items = @media_items.order(created_at: :desc)

  rescue ActiveRecord::RecordNotFound
    render "profiles/not_found", status: :not_found
  end
end
