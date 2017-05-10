class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
  has_many :goals, through: :taggings

  validates :name, presence: true
end
