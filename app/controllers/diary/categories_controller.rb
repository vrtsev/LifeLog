class Diary::CategoriesController < DiaryController
  before_action :set_category, only: %i[show edit update destroy]

  def show
    @posts = @category.diary_posts
                      .paginate(page: params[:page], per_page: 10)
  end

  def new; end

  def edit
    @posts = @category.diary_posts
                      .paginate(page: params[:page], per_page: 10)
  end

  def create
    @category = current_user.diary_categories.new(category_params)
    @category.color = rand(0..6)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
    else
      flash[:error] = 'Something went wrong.'
    end

    redirect_to diary_category_path(@category)
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated.'
    else
      flash[:error] = 'Something went wrong.'
    end

    redirect_to diary_category_path(@category)
  end

  def destroy
    @category.destroy
    redirect_to diary_posts_url,
                notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.diary_categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :color)
  end
end
