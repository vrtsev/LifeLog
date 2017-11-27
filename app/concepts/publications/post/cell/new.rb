module Publications::Post::Cell
  class New < Trailblazer::Cell
    # For helpers, which will be available here
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper
  end
end