class Publications::TagsController < PublicationsController
  def show
    @tag = Tag.find_by(name: params[:name])

    return unless @tag.present?
    @posts = Publication::Post.joins(:tags)
                              .where(tags: { name: @tag.name })
                              .paginate(page: params[:page], per_page: 10)
  end
end
