class Diary::SearchController < DiaryController
  def index
    @tags     = find_tags
    @posts    = find_posts.paginate(page: params[:posts_page], per_page: 10)
    @comments = find_comments.paginate(page: params[:comments_page], per_page: 10)
  end

  private

  def find_tags
    scope = Tag.joins(:taggings).joins(:posts)
               .where(posts: { user: current_user, type: 'Diary::Post' })
               .distinct
    return scope.none unless params[:query].present?

    TagsSearchQuery.new(
      scope, params[:query], params[:tag]
    ).results
  end

  def find_posts
    scope = current_user.diary_posts
    return scope.none if params[:query].blank? && params[:post].blank?
    
    PostsSearchQuery.new(
      current_user.diary_posts, params[:query], params[:post]
    ).results
  end

  def find_comments
    scope = current_user.diary_comments
    return scope.none unless params[:query].present?

    CommentsSearchQuery.new(
      scope, params[:query], params[:comment]
    ).results
  end
end
