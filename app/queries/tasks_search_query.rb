class TasksSearchQuery < BaseSearchQuery
  private

  def apply_filters!
    super
    filter_status if @conditions[:status].present?
  end

  def find_records
    @scope = @scope.where(
      'title LIKE :query', query: "%#{@query}%"
    )
  end

  def filter_status
    @scope = @scope.where(status: @conditions[:status])
  end
end
