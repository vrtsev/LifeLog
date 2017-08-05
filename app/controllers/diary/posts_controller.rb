class Diary::PostsController < DiaryController
  before_action :set_post,            only: %i[show edit update destroy]
  before_action :collect_posts,       only: %i[index new edit]
  before_action :set_user_categories, except: %i[show destroy]

  def index; end

  def show
    @categories = current_user.diary_categories
    @comments   = @post.comments.order(created_at: :desc)
  end

  def new; end

  def create
    @post = current_user.diary_posts.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created.'
    else
      flash[:error] = 'Произошла ошибка при создании.'
    end
    redirect_to diary_posts_path
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
    else
      flash[:error] = 'Произошла ошибка при редактировании.'
    end
    redirect_to diary_posts_path
  end

  def destroy
    @post.destroy
    redirect_to diary_posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = current_user.diary_posts.find(params[:id])
  end

  def set_user_categories
    @categories = current_user.diary_categories
  end

  def collect_posts
    @posts = current_user.diary_posts.order(created_at: :desc)
  end

  def post_params
    params.require(:post).permit \
      :title, :content, :supplemented, :supplemented_at, :pinned, :category_id,
      :all_tags, :created_at
  end
end
