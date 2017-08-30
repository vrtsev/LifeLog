class Publications::PostsController < PublicationsController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    scope = current_user.publication_posts.includes(:tags, :taggings).newly

    @pinned_posts = scope.pinned
    @posts        = scope.page(params[:page])
  end

  def show
    @comments = @post.comments.includes(:votes).newly
                     .page(params[:page])
  end

  def new
    @post = current_user.publication_posts.new
  end

  def create
    @post = current_user.publication_posts.new(post_params)

    if @post.save
      notify_followers
      flash[:notice] = 'Post was successfully created'

      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)
    @post.supplemented_at = DateTime.now if @post.supplemented_changed?

    if @post.save
      flash[:notice] = 'Post was successfully updated'

      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post was successfully destroyed'

    redirect_to posts_url
  end

  private

  def notify_followers
    current_user.followers.each do |follower|
      UserMailer.notify_follower(follower, @post.user, @post).deliver_later
    end
  end

  def set_post
    @post = current_user.publication_posts.includes(:tags, :taggings)
                        .find(params[:id])
  end

  def post_params
    params.require(:post).permit \
      :title, :content, :supplemented, :pinned, :visible, :commentable,
      :category_id, :all_tags
  end
end
