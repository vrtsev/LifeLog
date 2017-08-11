module ApplicationHelper
  def format_datetime(datetime)
    return '(неизвестно)' unless datetime

    datetime.strftime("%d.%m.%Y в %I:%M")
  end
end
