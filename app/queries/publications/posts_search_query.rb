class Publications::PostsSearchQuery < Publications::BaseSearchQuery
  private

  def scope
    @user.publication_posts
  end

  def apply_filters!
    super
    filter_supplemented if @conditions[:supplemented].present?
    filter_pinned if @conditions[:pinned].present?
    filter_visible if @conditions[:visible].present?
    filter_commenting if @conditions[:commenting].present?
    filter_date
  end

  def find_records
    @scope = @scope.where(
      'title LIKE :query OR content LIKE :query', query: "%#{@query}%"
    )
  end

  def filter_supplemented
    @scope = @scope.supplemented
  end

  def filter_pinned
    @scope = @scope.pinned
  end

  def filter_visible
    @scope = @scope.visible
  end

  def filter_commenting
    @scope = @scope.commenting
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
