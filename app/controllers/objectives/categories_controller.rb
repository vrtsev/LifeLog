class Objectives::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def show
    @goals = @category.goals.all
  end

  def new
    @category = current_user.goal_categories.new
  end

  def create
    @category = current_user.goal_categories.new(category_params)

    if @category.save
      redirect_to objectives_category_path(@category),
                  notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to objectives_category_path(@category),
                  notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to diary_posts_url,
                notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.goal_categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :color)
  end
end
