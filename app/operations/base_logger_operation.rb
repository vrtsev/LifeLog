class BaseLoggerOperation
  def initialize(goal, kind, **options)
    @action_goal = goal
    @kind        = kind
    @options     = options
  end

  def call
    return unless action_log_params[:content].present?

    @action_goal.actions.create(action_log_params)
  end

  private

  def build_content
    raise NotImplementedError
  end

  def action_log_params
    {
      content: build_content,
      kind: @kind,
    }
  end
end
