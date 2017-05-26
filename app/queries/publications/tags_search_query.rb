class Publications::TagsSearchQuery < Publications::BaseSearchQuery
  private

  def scope
    Tag.joins(:taggings).joins(:posts)
       .where(posts: { user: @user }).distinct
  end

  def find_records
    return nil if @query.blank?
    @scope = @scope.where(
      'name LIKE ?', "%#{@query}%"
    )
  end
end
