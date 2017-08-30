class Publications::CategoriesController < PublicationsController
  before_action :set_category, except: %i[new create]

  def show
    @posts = @category.publication_posts.page(params[:page])
  end

  def new; end

  def edit; end

  def create
    @category = current_user.publication_categories.new(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created'
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category was successfully updated'
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Category was successfully destroyed'

    redirect_to posts_url
  end

  private

  def set_category
    @category = current_user.publication_categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :description, :color)
  end
end
