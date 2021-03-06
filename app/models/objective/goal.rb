# == Schema Information
#
# Table name: goals
#
#  id                   :integer          not null, primary key
#  title                :string
#  description          :text
#  status               :integer          default("0")
#  progress             :integer          default("0")
#  start_date           :date
#  end_date             :date
#  overdue_notification :integer
#  parent_id            :integer
#  category_id          :integer
#  user_id              :integer          not null
#

class Objective::Goal < ApplicationRecord
  include Taggable

  # has_many :attachments
  has_many :subgoals, class_name: 'Objective::Goal',
                      foreign_key: 'parent_id', dependent: :destroy
  has_many :tasks, class_name: 'Objective::Task'
  has_many :actions, class_name: 'Objective::Action'

  belongs_to :user
  belongs_to :parent, optional: true, class_name: 'Objective::Goal'
  belongs_to :category, class_name: 'Objective::Category', optional: true

  validates :title, :user_id, presence: true

  scope :base, (-> { where parent_id: nil })

  enum status: %i[in_progress completed canceled overdue]

  def days_left
    current_date = Date.today
    days_left = (end_date - current_date).to_i

    return false if days_left <= 0
    days_left
  end
end
