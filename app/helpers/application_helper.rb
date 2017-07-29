module ApplicationHelper
  def render_date_for(obj)
    obj.created_at.strftime("%d.%m.%Y в %I:%M")
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
