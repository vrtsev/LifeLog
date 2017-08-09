# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text(65535)
#  supplemented    :boolean          default("0")
#  supplemented_at :datetime
#  pinned          :boolean          default("0")
#  visible         :boolean          default("1")
#  commentable     :boolean          default("1")
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Publication::Post < Post
  belongs_to :category,
             optional: true,
             class_name: 'Publication::Category'

  # has_many :photos
  # has_many :files
  # has_many :text_blocks
  has_many :comments, class_name: 'Publication::Comment', dependent: :destroy

  validates :title, presence: true
end
