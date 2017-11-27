class Publications::Post::Destroy < Trailblazer::Operation
  step :model!
  step :delete!

  def model!(options, params:, current_user:, **)
    options['model'] = current_user.publication_posts.find(params[:id])
  end

  def delete!(options, *)
    options['model'].destroy
  end
end