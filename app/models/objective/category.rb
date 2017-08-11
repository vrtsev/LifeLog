# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  color       :integer          default("0")
#  user_id     :integer          not null
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Objective::Category < Category
  has_many :goals, class_name: 'Objective::Goal'
end
