class Objectives::GoalsController < ObjectivesController
  before_action :find_goal, except: %i[index new create]

  def index; end

  def show
    @tasks   = @goal.tasks.base.newly
    @actions = @goal.actions.newly.page(params[:page])
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      flash[:notice] = 'Goal was successfully created.'
      redirect_to objectives_goal_path(@goal)
    else
      render :new
    end
  end

  def edit; end

  def update
    @goal.assign_attributes(goal_params)

    if @goal.save
      flash[:notice] = 'Goal was successfully updated.'
      redirect_to objectives_goal_path(@goal)
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy
    flash[:notice] = 'Goal was successfully destroyed.'

    redirect_to objectives_goals_path
  end

  private

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:objective_goal).permit(
      :title, :description, :status, :start_date, :end_date, :parent_id,
      :overdue_notification, :category_id, :all_tags
    )
  end
end
