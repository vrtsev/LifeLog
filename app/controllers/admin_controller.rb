class AdminController < ApplicationController
  layout 'admin'
  before_action :set_variables

  private

  def set_variables
    @users = User.all
  end
end