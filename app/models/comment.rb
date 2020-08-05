class Comment < ApplicationRecord
  # relationship with other models
  belongs_to :tutor_session
  belongs_to :user

  # validation
  validates :body, presence: true, length: {maximum: 500}

  # for keyword search
  include PgSearch::Model
  multisearchable against: [:body]
end
