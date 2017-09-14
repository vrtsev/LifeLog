class Objectives::ActionsController < ObjectivesController
  before_action :set_goal
  before_action :set_action, except: :create

  def create
    @action = @goal.actions.new(action_params)

    if @action.save
      flash[:notice] = 'You sucessfully add new action to this goal'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to objectives_goal_path(@goal)
  end

  def edit
    respond_to { |format| format.js }
  end

  def update
    if @action.update(action_params)
      flash[:notice] = 'Action has been edited'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to objectives_goal_path(@goal)
  end

  def destroy
    @action.destroy
    flash[:notice] = 'Action has been deleted'

    redirect_to objectives_goal_path(@goal)
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:goal_id])
  end

  def set_action
    @action = @goal.actions.find(params[:id])
  end

  def action_params
    params.require(:goal_action).permit(:content)
  end
end