class ObjectivesController < ApplicationController
  before_action :set_user, :set_categories, :set_goals, :set_filters, :set_overdue_goals
  layout 'objectives'

  # private

  def set_user
   @user = current_user
  end

  def set_categories
   @categories = set_user.goal_categories.order(created_at: :desc)
  end

  def set_goals
   @goals = set_user.goals.where(status: %i[in_progress overdue]).order(end_date: :desc)
  end

  def set_filters
    @filters = {
      'В процессе':   :in_progress,
      'Завершенные':  :completed,
      'Отмененные':   :canceled,
      'Просроченные': :overdue
    }
  end

  def set_overdue_goals
    current_date = DateTime.now
    overdued_goals = @goals.where('goals.end_date < ?', current_date)
    
    overdued_goals.update_all(status: 'overdue') if overdued_goals.present?
  end
end
