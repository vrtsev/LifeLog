class WelcomeController < ApplicationController
  before_action :check_auth

  def index; end

  private

  def check_auth
    redirect_to posts_path if user_signed_in?
  end
end
