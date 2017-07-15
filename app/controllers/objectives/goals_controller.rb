class Objectives::GoalsController < ApplicationController
  before_action :find_goal, only: %i[edit update destroy]

  def index
    @goals = current_user.goals.all
  end

  def show
    @goal = current_user.goals.find(params[:id])
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
    if @goal.update(goal_params)
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

  def find_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(
      :title, :description, :status,
      :start_date, :end_date, :parent_id
    )
  end
end
