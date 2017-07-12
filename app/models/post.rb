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
#  supplement_date :datetime
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :user

  validates :user_id, presence: true
  validates :content, length: { minimum: 2 }

  def all_tags
    tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
