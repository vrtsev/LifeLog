class Diary::CategoriesController < DiaryController
  before_action :set_category, except: %i[new create]

  def show
    @posts = @category.diary_posts.includes(:category, :tags, :taggings).newly
                      .page(params[:page])
  end

  def new; end

  def create
    @category = current_user.diary_categories.new(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to diary_category_path(@category)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
      redirect_to diary_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Category was successfully destroyed.'

    redirect_to diary_posts_url
  end

  private

  def set_category
    @category = current_user.diary_categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :color)
  end
end
