# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  post_id    :integer          not null
#  user_id    :integer          not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Publication::Comment < Comment
  belongs_to :post, class_name: 'Publication::Post'

  has_many   :votes, class_name: 'Publication::Vote'
  # has_many   :replies, class_name: 'Publication::Comment'
end
