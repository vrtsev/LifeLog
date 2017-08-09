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
      create_logger_action(:addition, task: @task.title)
      redirect_to objectives_goal_path(@goal),
                  notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      create_logger_action(:editing, task: @task.title)
      redirect_to objectives_goal_path(@goal),
                  notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    title = @task.title

    @task.destroy
    create_logger_action(:deletion, task: title)
    redirect_to objectives_goal_path(@goal),
                notice: 'Task was successfully destroyed.'
  end

  def done
    @task.completed!
    create_logger_action(:completion, task: @task.title)
    redirect_to objectives_goal_path(@goal),
                notice: 'Task has been completed'
  end

  def undone
    @task.actual!
    redirect_to objectives_goal_path(@goal),
                notice: 'Task is actual now'
  end

  private

  def create_logger_action(kind, **options)
    TaskLoggerOperation.new(@goal, kind, options).call
  end

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
