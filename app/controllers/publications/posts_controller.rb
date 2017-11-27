class Publications::PostsController < PublicationsController
  def index
    result = Publications::Post::Index.(params, current_user: current_user)

    @pinned_posts = result['scope'].pinned
    @posts        = result['scope'].page(params[:page])
  end

  def show
    result = Publications::Post::Show.(params, current_user: current_user)

    @post     = result['model']
    @comments = result['comments']
  end

  def new
    result = Publications::Post::Create::Present.(params, current_user: current_user)   # run will pass params and set variables '@model' and '@form'

    @model = result['model']
  end

  def create
    result = Publications::Post::Create.(params, current_user: current_user)

    if result.success?
      flash[:notice] = 'Post was successfully created'
      redirect_to post_path(result['model'])
    else
      render :new
    end
  end

  def edit
    result = Publications::Post::Update::Present.(params, current_user: current_user)

    @model = result['model']
  end

  def update
    result = Publications::Post::Update.(params, current_user: current_user)

    if result.success?
      flash[:notice] = 'Post was successfully updated'
      redirect_to post_path(result['model'])
    else
      render :edit
    end
  end

  def destroy
    result = Publications::Post::Destroy.(params, current_user: current_user)
    flash[:notice] = 'Post was successfully destroyed'

    redirect_to posts_url
  end
end
