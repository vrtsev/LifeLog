# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  content    :text
#  kind       :integer          default("0")
#  goal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Objective::Action < ApplicationRecord
  belongs_to :goal, class_name: 'Objective::Goal'

  enum kind: %i[user_action addition editing deletion completion]
end
