module ObjectivesHelper
  include Rails.application.routes.url_helpers

  def filter_menu_elements
    return unless set_filters.present?

    set_filters.inject([]) do |array, (name, key)|
      items_count = current_user.goals.send(key).count 
      array << { name: name, status: key, active: set_active_link(key), items_count: items_count }

      array
    end
  end

  def action_style(action)
    case action.kind
    when 'user_action' then { color: 'primary', icon: nil }
    when 'addition'    then { color: 'info',    icon: 'plus' }
    when 'editing'     then { color: 'warn', icon: 'pencil' }
    when 'deletion'    then { color: 'danger',  icon: 'times' }
    when 'completion'  then { color: 'success', icon: 'check' }
    end
  end

  def set_icon_for(goal_status)
    case goal_status
    when 'new_goal'    then 'fa fa-plus'
    when 'in_progress' then 'fa fa-spinner'
    when 'completed'   then 'fa fa-check'
    when 'canceled'    then 'fa fa-ban'
    when 'overdue'     then 'fa fa-clock-o'
    end
  end

  def define_current_page(controllers)
    controllers.each do |controller|
      return true if params[:controller].include?(controller)
    end
    false
  end

  def soon_overdued?(goal)
    current_date = Date.today
    days_left = (goal.end_date - current_date).to_i

    return true if days_left <= goal.overdue_notification
  end

  private

  def set_active_link(key)
    return unless key.present?
    return unless params[:goal].present?

    'active' if params[:goal][:status] == key.to_s
  end

  def set_filters
    {
      'В процессе':   :in_progress,
      'Завершенные':  :completed,
      'Отмененные':   :canceled,
      'Просроченные': :overdue
    }
  end
end