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

class Diary::Category < Category
  has_many :diary_posts, class_name: 'Diary::Post'
  # has_many :sub_categories, class_name: 'BlogCategory'
end
