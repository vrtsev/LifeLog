class Objectives::TasksController < ApplicationController
  before_action :find_goal
  before_action :find_task, only: %i[edit update destroy done undone]

  def new
    @task = @goal.tasks.new
  end

  def create
    @task = @goal.tasks.new(task_params)
    @task.user = current_user

    if @task.save
      redirect_to objectives_goal_path(@goal),
                  notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to objectives_goal_path(@goal),
                  notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to objectives_goal_path(@goal),
                notice: 'Task was successfully destroyed.'
  end

  def done
    @task.completed!
    redirect_to objectives_goal_path(@goal),
                notice: 'Task has been completed'
  end

  def undone
    @task.actual!
    redirect_to objectives_goal_path(@goal),
                notice: 'Task is actual now'
  end

  private

  def find_goal
    @goal = current_user.goals.find(params[:goal_id])
  end

  def find_task
    @task = @goal.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :status, :parent_id)
  end
end
