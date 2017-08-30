class Publications::TagsController < PublicationsController
  def show
    @tag = Tag.find_by(name: params[:name])
    return unless @tag.present?

    @posts    = scope.page(params[:posts_page])
    @my_posts = scope.where(posts: { user: current_user })
                     .page(params[:my_posts_page])
  end

  private

  def scope
    Publication::Post.includes(:tags, :taggings, :user)
                     .where(tags: { name: @tag.name })
  end
end
