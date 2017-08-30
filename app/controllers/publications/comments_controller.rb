class Publications::CommentsController < PublicationsController
  before_action :set_post
  before_action :set_comment, only: %i[edit update destroy]
  before_action :check_commentable, only: %i[create]

  def edit
    respond_to { |format| format.js }
  end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      flash[:notice] = 'Comment was successfully created'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment was successfully updated.'

    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def check_commentable
    return if @post.commentable

    flash[:error] = "Вы отключили комментарии к данной записи"
    redirect_to post_path(@post)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
