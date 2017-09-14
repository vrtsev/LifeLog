class Objectives::CategoriesController < ObjectivesController
  before_action :set_category, except: %i[new create]

  def show
    @goals = @category.goals.order(end_date: :desc)
  end

  def new
    @category = current_user.goal_categories.new
  end

  def create
    @category = current_user.goal_categories.new(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to objectives_goals_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to objectives_goals_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Category was successfully destroyed.'

    redirect_to objectives_goals_url
  end

  private

  def set_category
    @category = current_user.goal_categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :color)
  end
end
