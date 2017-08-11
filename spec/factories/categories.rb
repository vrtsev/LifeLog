# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  color       :integer          default("0")
#  user_id     :integer          not null
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :category do
    title 'Some category'
    description 'Some description'
    color 1

    user
  end
end
