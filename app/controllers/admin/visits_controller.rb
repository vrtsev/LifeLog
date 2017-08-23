class Admin::VisitsController < AdminController
  def index
    @visits = Visit.all.order(started_at: :desc)
                   .paginate(page: params[:page], per_page: 15)
  end

  def show
    @visit = Visit.find(params[:id])
    @events = @visit.ahoy_events.order(time: :desc)
                    .paginate(page: params[:page], per_page: 15)
  end

  def statistic
    @paged_visits = Visit.all.order(started_at: :desc)
                   .paginate(page: params[:page], per_page: 31)

    @grouped_visits = @paged_visits.group_by { |visit| visit.started_at.to_date }
  end
end
