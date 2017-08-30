# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string
#  content         :text
#  supplemented    :boolean          default("false")
#  supplemented_at :datetime
#  pinned          :boolean          default("false")
#  visible         :boolean          default("true")
#  commentable     :boolean          default("true")
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ApplicationRecord
  include Taggable

  belongs_to :user

  validates :user_id, presence: true
  validates :content, length: { minimum: 2 }

  scope :supplemented, (-> { where supplemented: true })
  scope :pinned,       (-> { where pinned: true })
  scope :unpinned,     (-> { where pinned: false })
  scope :visible,      (-> { where visible: true })
  scope :commentable,  (-> { where commentable: true })
end
