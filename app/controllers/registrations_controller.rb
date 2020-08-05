class RegistrationsController < Devise::RegistrationsController
  protected

  # this will be run just after a user succeeds in sign-up
  def after_sign_up_path_for(resource)
    profile = Profile.create
    current_user.profile = profile
    edit_profile_path(profile)
  end
end