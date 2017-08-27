class Publications::Users::PostsController < Publications::UsersController
  def index
    @posts = @user.publication_posts.visible.paginate(page: params[:page], per_page: 10)
    @categories = @user.publication_categories
  end

  def show
    @post = @user.publication_posts.find(params[:id])

    redirect_to user_posts_path(@user) unless @post.visible
    @comments = @post.comments.order(created_at: :desc)
                     .paginate(page: params[:page], per_page: 10)
  end
end
