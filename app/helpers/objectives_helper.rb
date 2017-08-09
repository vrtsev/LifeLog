module ObjectivesHelper
  include Rails.application.routes.url_helpers

  def build_filters_menu(filters)
    return unless filters.present?

    menu = filters.inject('') do |string, (name, key)|
      string << link_to(
        name, 
        objectives_search_index_path(goal: { status: key }), 
        class: "nav-link #{set_active_link(key)}"
      )
    end
    return menu.html_safe
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

  private

  def set_active_link(key)
    return unless key.present?
    return unless params[:goal].present?

    'active' if params[:goal][:status] == key.to_s
  end
end