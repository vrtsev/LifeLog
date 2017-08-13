class ActionsSearchQuery < BaseSearchQuery
  private

  def find_records
    @scope = @scope.where(
      'content LIKE :query', query: "%#{@query}%"
    )
  end
end
