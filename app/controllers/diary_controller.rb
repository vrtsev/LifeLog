class DiaryController < ApplicationController
  before_action :set_user, :set_user_categories
  layout 'diary'

  private

  def set_user
    @user = current_user
  end

  def set_user_categories
    @categories = set_user.diary_categories.order(created_at: :desc)
  end
end
