# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
  has_many :goals, through: :taggings, class_name: 'Objective::Goal'

  validates :name, presence: true
end
