class Objectives::GoalsController < ObjectivesController
  before_action :find_goal, only: %i[edit update destroy]

  def index
    @goals = current_user.goals.all
  end

  def show
    @goal    = current_user.goals.find(params[:id])
    @actions = @goal.actions.order(created_at: :desc)
    @tasks   = @goal.tasks.base.order(created_at: :desc)
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to objectives_goal_path(@goal),
                  notice: 'Goal was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @goal.assign_attributes(goal_params)
    changes = @goal.changes
    status  = @goal.status_change.last if @goal.status_changed?
    
    if @goal.save
      create_logger_action(changes: changes, status: status)
      redirect_to objectives_goal_path(@goal),
                  notice: 'Goal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy
    redirect_to objectives_goals_path,
                notice: 'Goal was successfully destroyed.'
  end

  private

  def create_logger_action(**options)
    kind = case options[:status]
    when 'completed' then :completion
    when 'canceled'  then :deletion
    when 'overdue'   then :deletion
    else :editing
    end

    GoalLoggerOperation.new(@goal, kind, options).call
  end

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:objective_goal).permit(
      :title, :description, :status, :start_date, :end_date, :parent_id,
      :category_id, :all_tags
    )
  end
end
