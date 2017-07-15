class Diary::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = current_user.diary_posts
  end

  def show; end

  def new
    @post = current_user.diary_posts.new
  end

  def create
    @post = current_user.diary_posts.new(post_params)

    if @post.save
      redirect_to diary_post_path(@post),
                  notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to diary_post_path(@post),
                  notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to diary_posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = current_user.diary_posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :content, :supplemented, :supplement_date, :pinned
    )
  end
end
