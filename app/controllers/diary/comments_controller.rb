class Diary::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[show edit update destroy]

  def new
    # @comment = @post.comments.new
  end

  def edit
    respond_to { |format| format.js }
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to diary_post_path(@post),
                  notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to diary_post_path(@post),
                  notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to diary_post_path(@post),
                notice: 'Comment was successfully destroyed.'
  end

  private

  def set_post
    @post = current_user.diary_posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
