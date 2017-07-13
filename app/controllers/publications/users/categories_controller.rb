class Publications::Users::CategoriesController < ApplicationController
  def show
    @user     = User.find(params[:user_id])
    @category = @user.publication_categories.find(params[:id])
    @posts    = @category.publication_posts.visible
  end
end
