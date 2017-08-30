class LandingPageController < ApplicationController
  layout 'landing_page'
  before_action :check_auth
  skip_before_action :authenticate_user!

  def index
    @blog_posts_count      = Publication::Post.count
    @diary_posts_count     = Diary::Post.count
    @completed_goals_count = Objective::Goal.completed.count
    @users_count           = User.count
  end

  private

  def check_auth
    redirect_to news_feed_path if user_signed_in?
  end
end
