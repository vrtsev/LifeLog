class Objectives::CategoriesController < ObjectivesController
  before_action :set_category, only: %i[show edit update destroy]

  def show
    @goals = @category.goals.order(end_date: :desc)
  end

  def new
    @category = current_user.goal_categories.new
  end

  def create
    @category = current_user.goal_categories.new(category_params)
    @category.color = rand(1..6)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to objectives_goals_path
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
    else
      flash[:error] = 'Something went wrong'
    end
    
    redirect_to objectives_goals_path
  end

  def destroy
    @category.destroy
    redirect_to objectives_goals_url,
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
