class Objectives::SearchController < ApplicationController
  def index
    @tags  = find_tags
    @goals = find_goals
    @tasks = find_tasks
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:goals)
               .where(goals: { user: current_user })
               .distinct

    TagsSearchQuery.new(
      scope, params[:query], params[:tag]
    ).results
  end

  def find_goals
    GoalsSearchQuery.new(
      current_user.goals, params[:query], params[:goal]
    ).results
  end

  def find_tasks
    scope = Objective::Task.where(user: current_user)

    TasksSearchQuery.new(
      scope, params[:query], params[:task]
    ).results
  end
end
