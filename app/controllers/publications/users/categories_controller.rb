class Publications::Users::CategoriesController < Publications::UsersController
  def show
    @category = @user.publication_categories.find(params[:id])
    @posts    = @category.publication_posts.visible.paginate(page: params[:page], per_page: 10)
  end
end
