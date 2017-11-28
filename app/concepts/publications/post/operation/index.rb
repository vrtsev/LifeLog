class Publications::Post::Index < Trailblazer::Operation
  step :get_scope

  def get_scope(options, params:, current_user:, **)
    options['scope'] = current_user.publication_posts.includes(:tags, :taggings).newly
                                   .paginate(page: params[:page], per_page: 10)
  end
end