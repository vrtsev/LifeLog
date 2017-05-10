# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  post_id    :integer          not null
#  user_id    :integer          not null
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    content 'Some example content'

    post
    user
  end
end
