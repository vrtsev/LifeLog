# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  color       :integer          default("0")
#  user_id     :integer          not null
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :publication_category, class: 'Publication::Category' do
    title 'Life category'
    description 'Some description'
    color 0

    user
  end

  trait :invalid do
    title nil
    description 'a'
  end
end
