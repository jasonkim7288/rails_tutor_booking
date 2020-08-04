class NotiSetting < ApplicationRecord
  belongs_to :user
  after_initialize :init

  private
    def init
      self.session_changed ||= true
      self.one_day_to_start ||= false
    end
end
