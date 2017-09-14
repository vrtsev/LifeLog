class Publications::Users::FollowsController < Publications::UsersController
  # @user variable defined in parent controller and means user's profile you visited

  def create
    current_user.follow(@user)

    respond_to do |format|
      format.html { redirect_to user_publications_path(user) }
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)

    respond_to do |format|
      format.html { redirect_to user_publications_path(user) }
      format.js
    end
  end
end
