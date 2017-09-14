class Diary::CommentsController < DiaryController
  before_action :set_post
  before_action :set_comment, except: %i[new create]

  def new; end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:error] = 'Something went wrong.'
    end
    redirect_to diary_post_path(@post)
  end

  def edit
    respond_to { |format| format.js }
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
    else
      flash[:error] = 'Something went wrong.'
    end
    redirect_to diary_post_path(@post)
  end

  def destroy
    @comment.destroy
    flash[:notice] = 'Comment was successfully destroyed.'

    redirect_to diary_post_path(@post)
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
