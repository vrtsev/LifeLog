class Diary::TagsController < DiaryController
  def show
    @tag = Tag.find_by(name: params[:name])

    return unless @tag.present?
    @posts = current_user.diary_posts.includes(:tags, :taggings, :category)
                         .where(tags: { name: @tag.name }).newly
                         .page(params[:page])
  end
end
