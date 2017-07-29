class Publications::VotesController < PublicationsController
  before_action :set_post, :set_comment

  def create
    @vote = @comment.votes.new(user: current_user)

    if @vote.save
      flash[:notice] = 'Vote was successfully created'
    else
      flash[:error] = 'Error. Try again'
    end
    redirect_to post_path(@post)
  end

  def destroy
    @vote = @comment.votes.find(params[:id])
    @vote.destroy
    redirect_to post_path(@post),
                notice: 'Vote was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end
end
