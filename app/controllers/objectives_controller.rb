class ObjectivesController < ApplicationController
  before_action :set_layout_variables
  layout 'objectives'

  private

  def set_layout_variables
    @categories = current_user.goal_categories.newly
    @goals      = current_user.goals.includes(:tasks)
                              .where(status: %i[in_progress overdue])
                              .order(end_date: :desc)
  end

  # TODO move this operation to scheduled job
  # def update_overdued_goals
  #   overdued_goals = @goals.where('goals.end_date < ?', DateTime.now)
  #   return unless overdued_goals.present?

  #   overdued_goals.update_all(status: 'overdue')
  # end
end
