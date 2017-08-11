# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string
#  content         :text
#  supplemented    :boolean          default("false")
#  supplemented_at :datetime
#  pinned          :boolean          default("false")
#  visible         :boolean          default("true")
#  commentable     :boolean          default("true")
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :post do
    title 'My shiny post'
    content 'Im writing booring tests'
    supplemented false
    pinned false
    visible true
    commentable true
    supplemented_at DateTime.current
    all_tags 'first_tag, second_tag'

    user
    category_id 1

    trait :invalid do
      title nil
    end
  end
end
