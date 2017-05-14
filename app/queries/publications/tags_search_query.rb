class Publications::TagsSearchQuery < Publications::BaseSearchQuery
  private

  def scope
    Tag.all
  end

  def find_records
    return nil if @query.blank?
    @scope = @scope.where(
      'name LIKE ?', "%#{@query}%"
    )
  end
end
