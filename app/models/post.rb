# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text(65535)
#  supplemented    :boolean          default("1")
#  pinned          :boolean          default("0")
#  visible         :boolean          default("1")
#  commentable     :boolean          default("1")
#  supplemented_at :datetime
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ApplicationRecord
  include Taggable

  belongs_to :user

  validates :user_id, presence: true
  validates :content, length: { minimum: 2 }

  scope :supplemented, (-> { where supplemented: true })
  scope :pinned, (-> { where pinned: true })
  scope :unpinned, (-> { where pinned: false })
  scope :visible, (-> { where visible: true })
  scope :commentable, (-> { where commentable: true })
end
