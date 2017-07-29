# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text(65535)
#  supplemented    :boolean          default("1")
#  pinned          :boolean          default("0")
#  visible         :boolean          default("1")
#  commentable     :boolean          default("1")
#  supplemented_at :datetime
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
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
