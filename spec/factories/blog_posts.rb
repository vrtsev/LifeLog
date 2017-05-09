FactoryGirl.define do
  factory :blog_post, class: 'BlogPost' do
    title 'My shiny post'
    content 'Im writing booring tests'
    supplemented false
    pinned false
    visible true
    commenting true
    supplement_date DateTime.current

    user
    category_id 1
  end
end
