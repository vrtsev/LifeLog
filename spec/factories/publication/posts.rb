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
#  commenting      :boolean          default("1")
#  supplement_date :datetime
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :publication_post, class: 'Publication::Post' do
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
