class Publications::BaseSearchQuery
  def initialize(user, query, conditions)
    @user       = user
    @query      = query
    @conditions = conditions || {}

    @scope = scope
    apply_filters!
  end

  def results
    @scope
  end

  private

  def scope; end

  def apply_filters!
    find_records
  end

  def find_records; end
end
