# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  color       :integer          default("0")
#  user_id     :integer          not null
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ApplicationRecord
  belongs_to :user

  validates :title, :user_id, presence: true
  validates :description, length: { minimum: 2 }
end
