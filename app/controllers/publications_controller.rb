class PublicationsController < ApplicationController
  layout 'publications'
  before_action :set_user_categories

  private

  def set_user_categories
    @categories = current_user.publication_categories
  end
end
