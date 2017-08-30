class PublicationsController < ApplicationController
  before_action :set_layout_variables
  layout 'publications'

  private

  def set_layout_variables
    @user        = current_user
    @posts_count = current_user.publication_posts.count
    @subscribers = current_user.followers.count
    @categories  = current_user.publication_categories
                               .order(created_at: :desc)
  end
end
