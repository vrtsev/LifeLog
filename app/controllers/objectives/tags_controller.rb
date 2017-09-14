class Objectives::TagsController < ObjectivesController
  def show
    @tag = Tag.find_by(name: params[:name])
    @goals = @tag.present? ? find_goals : nil
  end

  private

  def find_goals
    current_user.goals.joins(:tags).where(tags: { name: @tag.name })
  end
end
