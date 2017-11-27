class Publications::Post::Show < Trailblazer::Operation
  step :model!
  step :get_comments

  def model!(options, params:, current_user:, **)
    options['model'] = current_user.publication_posts.includes(:tags, :taggings)
                                   .find(params[:id])
  end

  def get_comments(options, params:, model:, **)
    options['comments'] = model.comments.includes(:votes).newly
                               .page(params[:page])
  end
end