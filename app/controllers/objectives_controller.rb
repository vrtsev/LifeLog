class ObjectivesController < ApplicationController
  before_action :set_user, :set_categories, :set_goals, :set_filters
  layout 'objectives'

  # private

  def set_user
   @user = current_user
  end

  def set_categories
   @categories = set_user.goal_categories.order(created_at: :desc)
  end

  def set_goals
   @goals = set_user.goals.order(end_date: :desc)
  end

  def set_filters
    @filters = {
      'Новые':        :new_goal,
      'В процессе':   :in_progress,
      'Завершенные':  :completed,
      'Отмененные':   :canceled,
      'Просроченные': :overdue
    }
  end
end
