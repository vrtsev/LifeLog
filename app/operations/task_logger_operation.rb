class TaskLoggerOperation
  def initialize(action, task, goal)
    @action = action
    @task   = task
    @goal   = goal
  end

  def call
    @goal.actions.create(action_params)
  end

  private

  def action_params
    {
      content: build_content,
      kind:    @action
    }
  end

  def build_content
    case @action
    when :addition   then addition_message
    when :editing    then editing_message
    when :deletion   then deletion_message
    when :completion then completion_message
    end
  end

  # Strings will be replaced with I18n keys
  def addition_message
    "Вы добавили задачу '#{@task.title}'"
  end

  def editing_message
    "Вы обновили задачу '#{@task.title}'"
  end

  def deletion_message
    "Вы удалили задачу '#{@task.title}'"
  end

  def completion_message
    "Задача '#{@task.title}' была успешно завершена"
  end
end
