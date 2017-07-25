class Objective::Task < ApplicationRecord
  has_many :subtasks, class_name: 'Objective::Task',
                      foreign_key: 'parent_id', dependent: :destroy
  belongs_to :goal
  belongs_to :user

  validates :user_id, :goal_id, presence: true

  scope :base, (-> { where parent_id: nil })

  enum status: %i[actual completed]
end
