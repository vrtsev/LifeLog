class Publications::UsersController < PublicationsController
  def index
    @users = User.all
  end

  def show
    user = User.find(params[:id])

    if user == current_user
      redirect_to posts_path
    else
      redirect_to user_posts_path(user)
    end
  end
end
