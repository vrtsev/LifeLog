class NewsFeedController < ApplicationController
  layout 'news_feed'

  def index
    @all_posts           = load_posts.page(params[:all_posts_page])
    @subscriptions_posts = load_posts.where(
      posts: { user_id: current_user.following.ids }
    ).page(params[:subscriptions_posts_page])

    @comments            = load_comments
    @popular_users       = load_popular_users
  end

  private

  def load_posts
    Publication::Post.includes(:tags, :taggings, :user)
                     .order(created_at: :desc)
  end

  def load_comments
    Publication::Comment.includes(:post, :user).order(created_at: :desc)
                        .limit(5)
  end

  def load_popular_users
    User
      .joins('LEFT JOIN relationships ON users.id = relationships.followed_id')
      .select('users.*, COUNT(relationships.follower_id) AS followers_count')
      .group('users.id').having('COUNT(relationships.follower_id) > 0')
      .order('followers_count DESC')
  end
end
