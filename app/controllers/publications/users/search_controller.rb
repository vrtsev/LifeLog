class Publications::Users::SearchController < ApplicationController
  before_action :set_user

  def index
    @tags     = find_tags
    @posts    = find_posts
    @comments = find_comments
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def find_tags
    Publications::TagsSearchQuery.new(
      @user, params[:query], params[:tag]
    ).results
  end

  def find_posts
    Publications::PostsSearchQuery.new(
      @user, params[:query], params[:post]
    ).results
  end

  def find_comments
    Publications::CommentsSearchQuery.new(
      @user, params[:query], params[:comment]
    ).results
  end
end
