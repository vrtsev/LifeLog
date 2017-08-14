class Publications::PostsController < PublicationsController
  before_action :set_post, only: %i[show edit update destroy pin unpin]

  def index
    @posts = current_user.publication_posts.order(created_at: :desc)
                         .paginate(page: params[:page], per_page: 10)
  end

  def show
    @comments = @post.comments.all.order(created_at: :desc)
                     .paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = current_user.publication_posts.new
  end

  def create
    @post = current_user.publication_posts.new(post_params)

    if @post.save
      notify_followers
      redirect_to post_path(@post),
                  notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      set_supplement_date if @post.supplemented
      redirect_to post_path(@post),
                  notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def notify_followers
    current_user.followers.each do |follower|
      UserMailer.notify_follower(follower, @post.user, @post).deliver_later
    end
  end

  def set_post
    @post = current_user.publication_posts.find(params[:id])
  end

  def set_supplement_date
    @post.supplemented_at = DateTime.now
    @post.save
  end

  def post_params
    params.require(:post).permit \
      :title, :content, :supplemented, :pinned, :visible, :commentable,
      :category_id, :all_tags
  end
end
