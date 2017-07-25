# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  post_id    :integer
#  goal_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :post, optional: true
  belongs_to :goal, class_name: 'Objective::Goal', optional: true
end
