# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  email      :string
#  subject    :string
#  message    :text
#  readed     :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feedback < ApplicationRecord
  validates :email, :subject, presence: true
  validates :message, length: { minimum: 3 }
end
