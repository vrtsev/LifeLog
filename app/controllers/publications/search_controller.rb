class Publications::SearchController < PublicationsController
  def index
    @tags     = find_tags
    @posts    = find_posts
    @comments = find_comments
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:posts)
               .where(posts: { user: current_user, type: 'Publication::Post' })
               .distinct

    TagsSearchQuery.new(
      scope, params[:query], params[:tag]
    ).results
  end

  def find_posts
    PostsSearchQuery.new(
      current_user.publication_posts, params[:query], params[:post]
    ).results
  end

  def find_comments
    CommentsSearchQuery.new(
      current_user.publication_comments, params[:query], params[:comment]
    ).results
  end
end
