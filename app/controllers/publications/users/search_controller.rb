class Publications::Users::SearchController < Publications::UsersController
  before_action :set_search_values

  def index
    @tags     = find_tags
    @posts    = find_posts.paginate(page: params[:posts_page], per_page: 10)
    @comments = find_comments.paginate(page: params[:comments_page], per_page: 10)
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:posts)
               .where(posts: { user: @user, type: 'Publication::Post' })
               .distinct
    
    return scope.none unless params[:query].present?

    TagsSearchQuery.new(
      scope, params[:query], params[:tag]
    ).results
  end

  def find_posts
    scope = @user.publication_posts
    return scope.none if params[:query].blank? && params[:post].blank?

    PostsSearchQuery.new(
      scope, params[:query], params[:post]
    ).results
  end

  def find_comments
    scope = @user.publication_comments
    return scope.none unless params[:query].present?

    CommentsSearchQuery.new(
      scope, params[:query], params[:comment]
    ).results
  end

  def set_search_values
    return unless params[:post].present?

    @filter_pinned       = params[:post][:pinned]
    @filter_supplemented = params[:post][:supplemented]
    @filter_visible      = params[:post][:visible]
    @filter_commentable  = params[:post][:commentable]
  end
end
