class Objectives::SearchController < ObjectivesController
  def index
    @goals   = find_goals
    @tags    = find_tags
    @actions = find_actions.paginate(page: params[:actions_page], per_page: 10)
    @tasks   = find_tasks.paginate(page: params[:tasks_page], per_page: 10)
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:goals)
               .where(goals: { user: current_user })
               .distinct
    return scope.none unless params[:query].present?

    TagsSearchQuery.new(
      scope, params[:query], params[:tag]
    ).results
  end

  def find_goals
    scope = current_user.goals
    return scope.none if params[:query].blank? && params[:goal].blank?

    GoalsSearchQuery.new(
      scope, params[:query], params[:goal]
    ).results
  end

  def find_actions
    scope = Objective::Action.joins(:goal).where(goals: { user: current_user })
    return scope.none unless params[:query].present?

    ActionsSearchQuery.new(
      scope, params[:query], params[:action]
    ).results
  end

  def find_tasks
    scope = Objective::Task.where(user: current_user)
    return scope.none unless params[:query].present?

    TasksSearchQuery.new(
      scope, params[:query], params[:task]
    ).results
  end
end
