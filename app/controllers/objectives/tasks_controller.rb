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
      recalculate_progress
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
    recalculate_progress
    redirect_to objectives_goal_path(@goal),
                notice: 'Task was successfully destroyed.'
  end

  def done
    @task.completed!
    create_logger_action(:completion, task: @task.title)
    recalculate_progress
    redirect_to objectives_goal_path(@goal),
                notice: 'Task has been completed'
  end

  def undone
    @task.actual!
    recalculate_progress
    redirect_to objectives_goal_path(@goal),
                notice: 'Task is actual now'
  end

  def sort
    params[:order].each do |key,value|
      @goal.tasks.find(value[:id]).update_attribute(:position, value[:position])
    end

    head :ok
  end

  private

  def recalculate_progress
    all_tasks       = @goal.tasks.count.to_f
    completed_tasks = @goal.tasks.completed.count.to_f
    
    if completed_tasks.zero?
      @goal.update(progress: 0)  
    else
      progress = (completed_tasks / all_tasks ) * 100
      @goal.update(progress: progress)

      complete_goal if @goal.progress == 100
    end
  end

  def complete_goal
    @goal.completed!
    GoalLoggerOperation.new(@goal, :completion, status: @goal.status).call
    flash[:notice] = 'Поздравляем! Вы успешно выполнили цель'
  end

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
