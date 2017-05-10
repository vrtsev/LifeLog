module Publications::PostsHelper
  def user_vote(comment)
    comment.votes.find_by(user: current_user)
  end
end
