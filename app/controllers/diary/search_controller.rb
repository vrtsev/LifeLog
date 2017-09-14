class Diary::SearchController < DiaryController
  before_action :set_filter_values

  def index
    @tags     = find_tags
    @posts    = find_posts.page(params[:posts_page])
    @comments = find_comments.page(params[:comments_page])
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:posts)
               .where(posts: { user: current_user, type: 'Diary::Post' })
               .distinct
    return scope.none unless params[:query].present?

    TagsSearchQuery.new(scope, params[:query], params[:tag]).results
  end

  def find_posts
    scope = current_user.diary_posts.includes(:tags, :taggings)
    return scope.none if params[:query].blank? && params[:post].blank?

    PostsSearchQuery.new(
      current_user.diary_posts, params[:query], params[:post]
    ).results
  end

  def find_comments
    scope = current_user.diary_comments.includes(:post)
    return scope.none unless params[:query].present?

    CommentsSearchQuery.new(scope, params[:query], params[:comment]).results
  end

  def set_filter_values
    return unless params[:post].present?

    @filter_pinned       = params[:post][:pinned]
    @filter_supplemented = params[:post][:supplemented]
  end
end
