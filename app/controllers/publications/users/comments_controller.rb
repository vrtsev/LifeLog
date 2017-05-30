class Publications::Users::CommentsController < ApplicationController
  before_action :set_user, :set_post
  before_action :set_comment, :check_author, only: %i[edit update destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post),
                  notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to user_post_path(@user, @post),
                  notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:error] = 'Error hapenned. Try again'
    end

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Publication::Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def check_author
    return if @comment.user == current_user

    flash[:error] = 'Error. You are not the author of this comment'
    redirect_to user_post_path(@user, @post)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
