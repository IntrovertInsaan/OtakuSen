# frozen_string_literal: true

class MediaItemQuery
  def initialize(scope = MediaItem.all, params = {})
    @scope = scope
    @params = params
  end

  def call
    scope = @scope.includes(:tags, :category)
    scope = filter_by_category(scope)
    scope = filter_by_tag(scope)
    scope = search(scope)
    sort(scope)
  end

  private

  def filter_by_category(scope)
    @params[:category_id].present? ? scope.where(category_id: @params[:category_id]) : scope
  end

  def filter_by_tag(scope)
    @params[:tag].present? ? scope.joins(:tags).where(tags: { name: @params[:tag] }) : scope
  end

  def search(scope)
    @params[:search].present? ? scope.search_by_all_content(@params[:search]) : scope
  end

  def sort(scope)
    sort_order = case @params[:sort]
    when "highest_rated"    then "media_items.rating DESC NULLS LAST"
    when "recently_updated" then "media_items.updated_at DESC"
    when "title_asc"        then "media_items.title ASC"
    when "title_desc"       then "media_items.title DESC"
    else "media_items.created_at DESC"
    end
    scope.order(sort_order)
  end
end
