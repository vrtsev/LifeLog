class Publications::Post::Index < Trailblazer::Operation
  step :get_scope

  def get_scope(options, current_user:, **)
    options['scope'] = current_user.publication_posts.includes(:tags, :taggings).newly
  end
end