class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :post
  # belongs_to :goal
end
