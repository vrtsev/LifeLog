class Objectives::TasksController < ObjectivesController
  before_action :find_goal
  before_action :find_task, except: %i[new create]

  def new
    @task = @goal.tasks.new
  end

  def create
    @task = @goal.tasks.new(task_params.merge(user: current_user))

    if @task.save
      TaskLoggerOperation.new(:addition, @task, @goal).call
      recalculate_progress
      flash[:notice] = 'Task was successfully created.'
      redirect_to objectives_goal_path(@goal)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      TaskLoggerOperation.new(:editing, @task, @goal).call
      flash[:notice] = 'Task was successfully updated.'
      redirect_to objectives_goal_path(@goal)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    TaskLoggerOperation.new(:deletion, @task, @goal).call
    recalculate_progress
    flash[:notice] = 'Task was successfully destroyed.'

    redirect_to objectives_goal_path(@goal)
  end

  def done
    @task.completed!
    TaskLoggerOperation.new(:completion, @task, @goal).call
    recalculate_progress
    flash[:notice] = 'Task has been completed'

    redirect_to objectives_goal_path(@goal)
  end

  def undone
    @task.actual!
    recalculate_progress
    flash[:notice] = 'Task is actual now'

    redirect_to objectives_goal_path(@goal)
  end

  def sort
    params[:order].each do |key, value|
      task = @goal.tasks.find(value[:id])
      task.update_attribute(:position, value[:position])
    end

    head :ok
  end

  private

  def recalculate_progress
    all_tasks_count       = @goal.tasks.count.to_f
    completed_tasks_count = @goal.tasks.completed.count.to_f
    return @goal.update(progress: 0) if completed_tasks_count.zero?

    progress = (completed_tasks_count / all_tasks_count ) * 100
    @goal.update(progress: progress)

    complete_goal! if @goal.progress == 100
  end

  def complete_goal!
    @goal.completed!
    flash[:notice] = 'Поздравляем! Вы успешно выполнили цель'
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
