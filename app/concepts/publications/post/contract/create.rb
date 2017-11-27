module Publications::Post::Contract
  class Create < Reform::Form
    property :title
    property :content
    property :supplemented
    property :pinned
    property :visible
    property :commentable
    property :category_id
    property :all_tags

    validates :title,   presence: true
    # validates :user_id, presence: true
    validates :content, length: { minimum: 2 }
  end
end