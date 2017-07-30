class PublicationsController < ApplicationController
  before_action :set_user, :set_user_categories
  layout 'publications'

  private

  def set_user
    @user = current_user
  end

  def set_user_categories
    @categories = set_user.publication_categories
  end
end
