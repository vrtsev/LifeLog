module Publications::Post::Cell
  class Index < Trailblazer::Cell
    # For helpers, which will be available here
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper

    def scope
      @model
    end

    def pinned_posts
      @model.pinned
    end

    def posts
      @model.page(params[:page])
    end
  end
end