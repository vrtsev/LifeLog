class Publications::SearchController < PublicationsController
  before_action :set_filter_values

  def index
    @tags     = find_tags
    @posts    = find_posts.page(params[:posts_page])
    @comments = find_comments.page(params[:comments_page])
  end

  private

  def find_tags
    scope = Tag.includes(:taggings, :posts)
               .where(posts: { user: current_user, type: 'Publication::Post' })
               .distinct
    return scope.none unless params[:query].present?

    TagsSearchQuery.new(scope, params[:query], params[:tag]).results
  end

  def find_posts
    scope = current_user.publication_posts.includes(:tags, :taggings)
    return scope.none if params[:query].blank? && params[:post].blank?

    PostsSearchQuery.new(scope, params[:query], params[:post]).results
  end

  def find_comments
    scope = current_user.publication_comments.includes(:post, :votes, :user)
                        .where(posts: {user: current_user})
    return scope.none unless params[:query].present?

    CommentsSearchQuery.new(scope, params[:query], params[:comment]).results
  end

  def set_filter_values
    return unless params[:post].present?

    @filter_pinned       = params[:post][:pinned]
    @filter_supplemented = params[:post][:supplemented]
    @filter_visible      = params[:post][:visible]
    @filter_commentable  = params[:post][:commentable]
  end
end
