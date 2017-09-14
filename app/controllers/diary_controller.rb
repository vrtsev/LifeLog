class DiaryController < ApplicationController
  before_action :set_layout_variables
  layout 'diary'

  private

  def set_layout_variables
    @posts_count = current_user.diary_posts.count
    @categories  = current_user.diary_categories.newly
  end
end
