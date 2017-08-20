# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string
#  status     :integer          default("0")
#  position   :integer          default("0")
#  user_id    :integer          not null
#  goal_id    :integer          not null
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Objective::Task < ApplicationRecord
  has_many :subtasks, class_name: 'Objective::Task',
                      foreign_key: 'parent_id', dependent: :destroy
  belongs_to :goal
  belongs_to :user

  validates :user_id, :goal_id, presence: true

  default_scope { order("position ASC") }
  scope :base, (-> { where parent_id: nil })

  enum status: %i[actual completed]
end
