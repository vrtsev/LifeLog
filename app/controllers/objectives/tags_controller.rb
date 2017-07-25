class Objectives::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    @goals = current_user.goals.joins(:tags)
                         .where(tags: { name: @tag.name })
  end
end
