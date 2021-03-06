class Publications::UsersController < PublicationsController
  layout 'user_publications'
  skip_before_action :authenticate_user!

  private

  # Override 'before_action' method which defined in PublicationsController
  def set_layout_variables
    @user        = User.find(params[:user_id])
    @posts_count = @user.publication_posts.visible.count
    @subscribers = @user.followers.count
    @categories  = @user.publication_categories.newly
  end
end
