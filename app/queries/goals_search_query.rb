class GoalsSearchQuery < BaseSearchQuery
  private

  def apply_filters!
    super
    filter_status if @conditions[:status].present?
    filter_date
  end

  def find_records
    @scope = @scope.where(
      'title LIKE :query OR description LIKE :query', query: "%#{@query}%"
    )
  end

  def filter_status
    @scope = @scope.where(status: @conditions[:status])
  end

  def filter_date
    return @scope if @conditions[:from_date].blank?
    @scope = @scope.where(
      'start_date > ? AND start_date < ?',
      @conditions[:from_date].to_datetime,
      @conditions[:to_date].to_datetime
    )
  end
end
