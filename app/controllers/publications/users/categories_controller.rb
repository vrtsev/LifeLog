class Publications::Users::CategoriesController < Publications::UsersController
  def show
    @category = @user.publication_categories.find(params[:id])
    @posts    = @category.publication_posts.visible.page(params[:page])
  end
end
