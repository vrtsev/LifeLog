class Publications::Users::PostsController < Publications::UsersController
  def index
    @posts      = @user.publication_posts.visible.newly.page(params[:page])
    @categories = @user.publication_categories
  end

  def show
    @post = @user.publication_posts.visible.find(params[:id])

    redirect_to user_posts_path(@user) unless @post.visible
    @comments = @post.comments.newly.page(params[:page])
  end
end
