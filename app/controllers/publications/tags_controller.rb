class Publications::TagsController < PublicationsController
  def show
    @tag = Tag.find_by(name: params[:name])

    return unless @tag.present?
    scope = Publication::Post.joins(:tags)
                             .where(tags: { name: @tag.name })
    
    @posts    = scope.paginate(page: params[:posts_page], per_page: 10)
    @my_posts = scope.where(posts: { user: current_user }).paginate(page: params[:my_posts_page], per_page: 10)
  end
end
