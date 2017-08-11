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
