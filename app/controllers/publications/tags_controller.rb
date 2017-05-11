class Publications::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    @posts = current_user.publication_posts.joins(:tags)
                         .where(tags: { name: @tag.name })
  end
end
