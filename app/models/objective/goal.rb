# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  status      :integer          default("0")
#  progress    :integer          default("0")
#  start_date  :datetime
#  end_date    :datetime
#  parent_id   :integer
#  user_id     :integer          not null
#

class Objective::Goal < ApplicationRecord
  # has_many :taggings, as: :taggable
  # has_many :tags, through: :taggings

  # has_many :subgoals
  # has_many :attachments

  belongs_to :user
  validates :title, :user_id, presence: true

  enum status: %i[new_goal in_progress completed canceled overdue]
end
