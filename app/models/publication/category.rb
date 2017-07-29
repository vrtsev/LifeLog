# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  color       :integer          default("0")
#  user_id     :integer          not null
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Publication::Category < Category
  has_many :publication_posts, class_name: 'Publication::Post'
  # has_many :sub_categories, class_name: 'BlogCategory'

  enum color: %i[grey red green yellow blue]
end
