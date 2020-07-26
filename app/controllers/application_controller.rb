class ApplicationController < ActionController::Base
  before_action :set_user_name

  private
    # if a user didn't update his or her name, use email for user name. If a user updated, use full name for user name
    def set_user_name
      if user_signed_in?
        @user_name = current_user.profile.full_name
      end
    end
end
