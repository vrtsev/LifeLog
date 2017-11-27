class Publications::Post::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :model!
    step Contract::Build(constant: Publications::Post::Contract::Create)

    def model!(options, current_user:, params:, **)
      options['model'] = current_user.publication_posts.find(params[:id])
    end
  end

  step Nested(Present)
  step Contract::Validate(key: 'publication_post')
  step Contract::Persist()
end
