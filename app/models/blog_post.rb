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
#  commenting      :boolean          default("1")
#  supplement_date :datetime
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class BlogPost < Post
  belongs_to :category, optional: true

  # has_many :photos
  # has_many :files
  # has_many :text_blocks
  # has_many :comments, as: :commentable

  validates :title, presence: true
end
