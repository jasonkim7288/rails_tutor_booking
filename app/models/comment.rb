class Comment < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:body]
  belongs_to :tutor_session
  belongs_to :user
end
