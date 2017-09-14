class Diary::PostsController < DiaryController
  before_action :set_post, except: %i[index new create]

  def index
    @posts = current_user.diary_posts.includes(:category, :tags, :taggings)
                         .newly.page(params[:page])
  end

  def show
    @comments = @post.comments.newly
  end

  def new; end

  def create
    @post = current_user.diary_posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to diary_posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to diary_posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post was successfully destroyed'

    redirect_to diary_posts_path
  end

  private

  def set_post
    @post = current_user.diary_posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit \
      :title, :content, :supplemented, :supplemented_at, :pinned, :category_id,
      :all_tags, :created_at
  end
end
