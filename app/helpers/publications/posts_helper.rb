module Publications::PostsHelper
  def user_vote_on(comment)
    comment.votes.find_by(user: current_user)
  end
end
