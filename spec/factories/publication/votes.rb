# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#

FactoryGirl.define do
  factory :publication_vote, class: 'Publication::Vote' do
    user
    comment
  end
end
