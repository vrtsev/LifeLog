class Publications::TagsController < ApplicationController
  def show
    @tag = Tag.find_by(name: params[:name])
    @posts = Publication::Post.joins(:tags)
                              .where(tags: { name: @tag.name })
  end
end
