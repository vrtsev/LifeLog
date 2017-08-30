class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newly, (-> { order created_at: :desc })
end
