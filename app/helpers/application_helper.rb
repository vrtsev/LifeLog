module ApplicationHelper
  def format_datetime(datetime)
    return '(неизвестно)' unless datetime

    datetime.strftime("%d.%m.%Y в %I:%M")
  end

  def render_photo_of(user, html_class='img-circle')
    photo_path = if user.avatar.present?
      user.avatar_url
    else
      '/images/user_avatar_placeholder.jpg'
    end

    image_tag(photo_path, class: html_class)
  end
end
