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

class Diary::Post < Post
  # has_many   :attachments
  has_many :comments, class_name: 'Diary::Comment', dependent: :destroy
  belongs_to :category,
             optional: true,
             class_name: 'Diary::Category'
end
