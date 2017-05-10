class Publications::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:id])
    @posts = current_user.publication_posts.joins(:tags)
                         .where(tags: { name: @tag.name })
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
