class Publications::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_user_categories, only: %i[index new edit]

  def index
    @posts = current_user.publication_posts
  end

  def show
    @comments = @post.comments.all
  end

  def new
    @post = current_user.publication_posts.new
  end

  def edit; end

  def create
    @post = current_user.publication_posts.new(post_params)

    if @post.save
      redirect_to post_path(@post),
                  notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
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

  def set_post
    @post = current_user.publication_posts.find(params[:id])
  end

  def set_user_categories
    @categories = current_user.publication_categories
  end

  def post_params
    params.require(:post).permit \
      :title, :content, :supplemented, :pinned, :visible, :commenting,
      :supplement_date, :category_id, :all_tags
  end
end
