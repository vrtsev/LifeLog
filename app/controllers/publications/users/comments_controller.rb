class Publications::Users::CommentsController < Publications::UsersController
  before_action :set_post, :check_commentable
  before_action :set_comment, :check_author, only: %i[edit update destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      notify_post_author
      flash[:notice] = 'Comment was successfully created'

      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def edit
    respond_to { |format| format.js }
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to user_post_path(@user, @post)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:error]  = 'Error hapenned. Try again'
    end

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_post
    @post = Publication::Post.visible.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def check_author
    return if @comment.user == current_user

    flash[:error] = 'Error. You are not the author of this comment'
    redirect_to user_post_path(@user, @post)
  end

  def check_commentable
    return if @post.commentable

    flash[:error] = "#{@user.name} has disabled commenting on this post"
    redirect_to user_post_path(@user, @post)
  end

  def notify_post_author
    UserMailer.notify_post_author(current_user, @post.user, @comment)
              .deliver_later
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
