class Admin::FeedbacksController < AdminController
  def index
    @feedbacks = Feedback.all.order(created_at: :desc)
                         .paginate(page: params[:page], per_page: 10)
  end
end