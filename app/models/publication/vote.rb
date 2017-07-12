# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment_id :integer          not null
#

class Publication::Vote < ApplicationRecord
  belongs_to :user
  belongs_to :comment, class_name: 'Publication::Comment'

  validates :user, uniqueness: {scope: :comment_id}
end
