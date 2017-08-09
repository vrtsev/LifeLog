class GoalLoggerOperation < BaseLoggerOperation
  private

  def build_content
    # Strings will be replaced with I18n keys
    if @options[:status].present?
      case @options[:status]
      when 'in_progress' then in_progress_message
      when 'completed'   then completed_message
      when 'canceled'    then canceled_message
      when 'overdue'     then overdue_message
      end
    else
      editing_message
    end
  end

  def editing_message
    return unless @options[:changes].present?
    changes = @options[:changes].to_h
    changes.map! {|attr, value| "#{attr}: #{value.last}" }.join(', ')

    "Вы внесли следующие изменения в Вашу цель: #{changes}"
  end

  def in_progress_message
    "Вы начали делать первые шаги к достижению цели. Успехов Вам!"
  end

  def completed_message
    "Цель была успешно достигнута. Поздравляем!"
  end

  def canceled_message
    "Данная цель была отменена Вами"
  end

  def overdue_message
    "Вы превысили указанные в цели сроки. Цель просрочена"
  end
end
