class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :track_activity

  private

  def track_activity
    return unless current_user.present?

    ahoy.track("#{params[:controller]} > #{action_name}", params)
  end
end
