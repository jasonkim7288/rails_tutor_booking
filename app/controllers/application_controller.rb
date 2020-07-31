class ApplicationController < ActionController::Base
  before_action :set_user_info

  private
    #
    # when setting the initaial avatar as a profile image, if a user didn't update his or her name, use email for user name.
    # If a user updated, use full name for user name
    def set_user_info
      if user_signed_in?
        @user_name = current_user.profile.full_name
        @profile_image = current_user.profile.get_profile_image(@user_name)
      end
    end
end
