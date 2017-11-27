class Publications::Post::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Publication::Post, :new)
    step Contract::Build(constant: Publications::Post::Contract::Create)
  end

  step Nested(Present)
  step :assign_user
  step Contract::Validate(key: 'publication_post')
  step Contract::Persist()
  success :notify_followers

  def assign_user(options, model:, current_user:, **)
    model.user = current_user
  end

  def notify_followers(options, current_user:, model:, **)
    # TODO ??Implement background job for this mailer to prevent long loading
    current_user.followers.each do |follower|
      UserMailer.notify_follower(follower, model.user, model).deliver_later
    end
  end
end
