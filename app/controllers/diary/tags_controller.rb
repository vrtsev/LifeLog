class Diary::TagsController < DiaryController
  def show
    @tag = Tag.find_by(name: params[:name])

    if @tag.present?
      @posts = current_user.diary_posts.joins(:tags)
                          .where(tags: { name: @tag.name })
                          .paginate(page: params[:page], per_page: 10)
    end
  end
end
