class AdminController < ApplicationController
  layout 'admin'
  before_action :check_admin, :set_layout_variables
  skip_before_action :track_activity

  private

  def check_admin
    return if current_user.admin?

    flash[:error] = 'You don\'t have permissions to visit this page'
    redirect_to root_path
  end

  def set_layout_variables
    @users_count = User.all.count
    @visits_per_day = Visit.where("DATE(started_at) = ?", DateTime.now).count
  end
end