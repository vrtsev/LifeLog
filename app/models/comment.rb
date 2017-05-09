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

class Comment < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, length: { minimum: 2 }
end
