class Publications::Users::PostsController < Publications::UsersController
  before_action :set_user

  def index
    @posts = @user.publication_posts.visible
    @categories = @user.publication_categories
  end

  def show
    @post = @user.publication_posts.find(params[:id])

    redirect_to user_posts_path(@user) unless @post.visible
    @comments = @post.comments.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
