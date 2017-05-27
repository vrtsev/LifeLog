class Publications::Users::PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.publication_posts
    @categories = @user.publication_categories
  end

  def show
    @post = @user.publication_posts.find(params[:id])
    @comments = @post.comments.all
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
