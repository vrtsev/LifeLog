class TaskLoggerOperation < BaseLoggerOperation
  private

  def build_content
    # Strings will be replaced with I18n keys

    case @kind
    when :addition   then addition_message
    when :editing    then editing_message
    when :deletion   then deletion_message
    when :completion then completion_message
    end
  end

  def addition_message
    "Вы добавили задачу '#{@options[:task]}'"
  end

  def editing_message
    "Вы обновили задачу '#{@options[:task]}'"
  end

  def deletion_message
    "Вы удалили задачу '#{@options[:task]}'"
  end

  def completion_message
    "Задача '#{@options[:task]}' была успешно завершена"
  end
end
