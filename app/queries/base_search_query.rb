class BaseSearchQuery
  def initialize(scope, query, conditions)
    @scope      = scope
    @query      = query
    @conditions = conditions || {}

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
