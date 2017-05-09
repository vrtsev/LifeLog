# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  post_id    :integer          not null
#  user_id    :integer          not null
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Publication::Comment < Comment
  belongs_to :post, class_name: 'Publication::Post'

  # has_many   :replies, class_name: 'Publication::Comment'
  # has_many   :votes
end
