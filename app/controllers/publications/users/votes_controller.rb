class Publications::Users::VotesController < ApplicationController
  before_action :set_post, :set_comment

  def create
    @vote = @comment.votes.new(user: current_user)

    if @vote.save
      flash[:notice] = 'Vote was successfully created'
    else
      flash[:error]  = 'Error. Try again'
    end

    redirect_to user_post_path(@user, @post)
  end

  def destroy
    @vote = @comment.votes.find(params[:id])
    @vote.destroy
    flash[:notice] = 'Vote was successfully destroyed'

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_post
    @post = @user.publication_posts.visible.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id])
  end
end
