class TagsSearchQuery < BaseSearchQuery
  private

  def find_records
    return nil if @query.blank?
    @scope = @scope.where(
      'name LIKE ?', "%#{@query}%"
    )
  end
end
