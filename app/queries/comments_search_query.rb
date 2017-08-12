class CommentsSearchQuery < BaseSearchQuery
  private

  def apply_filters!
    super
    filter_date
  end

  def find_records
    return nil if @query.blank?
    @scope = @scope.where(
      'comments.content LIKE ?', "%#{@query}%"
    )
  end

  def filter_date
    return @scope if @conditions[:from_date].blank?
    @scope = @scope.where(
      'created_at > ? AND created_at < ?',
      @conditions[:from_date].to_datetime,
      @conditions[:to_date].to_datetime
    )
  end
end
