class AdminController < ApplicationController
  layout 'admin'
  before_action :set_variables
  skip_before_action :track_activity

  private

  def set_variables
    @users = User.all
    @visits_per_day = Visit.where("DATE(started_at) = ?", DateTime.now).count
  end
end