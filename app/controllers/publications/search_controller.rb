class Publications::SearchController < ApplicationController
  def index
    @tags     = find_tags
    @posts    = find_posts
    @comments = find_comments
  end

  private

  def find_tags
    Publications::TagsSearchQuery.new(
      current_user, params[:query], params[:tag]
    ).results
  end

  def find_posts
    Publications::PostsSearchQuery.new(
      current_user, params[:query], params[:post]
    ).results
  end

  def find_comments
    Publications::CommentsSearchQuery.new(
      current_user, params[:query], params[:comment]
    ).results
  end
end
