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

  # has_many :attachments
  has_many :subgoals, class_name: 'Objective::Goal',
                      foreign_key: 'parent_id', dependent: :destroy
  has_many :tasks, class_name: 'Objective::Task'

  belongs_to :user
  belongs_to :parent, optional: true, class_name: 'Objective::Goal'

  validates :title, :user_id, presence: true

  scope :base, (-> { where parent_id: nil })

  enum status: %i[new_goal in_progress completed canceled overdue]
end
