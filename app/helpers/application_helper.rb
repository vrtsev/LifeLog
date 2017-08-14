module ApplicationHelper
  def format_datetime(datetime)
    return '(неизвестно)' unless datetime

    datetime.strftime("%d.%m.%Y в %I:%M")
  end

  def item_selected?(path)
    return ' selected' if current_page?(path)
  end

  def nav_section_selected?(section)
    return ' selected' if current_controller?(section)
  end

  def current_controller?(names)
    return false unless params[:controller] 
    params[:controller].include?(names)
  end
end
