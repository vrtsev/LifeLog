class LandingPageController < ApplicationController
  layout 'landing_page'
  before_action :check_auth

  def index
    @blog_posts_count      = Publication::Post.count
    @diary_posts_count     = Diary::Post.count
    @completed_goals_count = Objective::Goal.completed.count
    @users_count           = User.count
  end

  private

  def check_auth
    redirect_to posts_path if user_signed_in?
  end
end
