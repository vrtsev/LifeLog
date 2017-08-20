class NewsFeedController < ApplicationController
  layout 'news_feed'
  
  def index
    @all_posts = Publication::Post.order(created_at: :desc).paginate(page: params[:all_posts_page], per_page: 10)
    @subscriptions_posts = Publication::Post.joins(:user).where(posts: { user_id: current_user.following.ids })
                                            .order(created_at: :desc)
                                            .paginate(page: params[:subscriptions_posts_page], per_page: 10)

    @comments = Publication::Comment.order(created_at: :desc).limit(5)
    @popular_users = User.joins('LEFT JOIN relationships ON users.id = relationships.followed_id')
                         .select('users.*, COUNT(relationships.follower_id) AS followers_count')
                         .group('users.id').having('COUNT(relationships.follower_id) > 0')
                         .order('followers_count DESC')
  end
end