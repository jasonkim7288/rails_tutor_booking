class Attendance < ApplicationRecord
  belongs_to :tutor_session
  belongs_to :user
end
