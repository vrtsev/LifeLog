json.array!(@goals) do |goal|
  json.extract! goal, :id, :title, :description
  json.start goal.start_date
  json.end goal.end_date
  json.url objectives_goal_url(goal, format: :html)
end