class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])

    # Load all categories to display as filter links
    @categories = Category.all.order(:name)

    # Start with the specific user's media items
    @media_items = @user.media_items

    # If a category_id is present in the URL, filter by it
    if params[:category_id].present?
      @media_items = @media_items.where(category_id: params[:category_id])
    end

    @media_items = @media_items.order(created_at: :desc)
  end
end
