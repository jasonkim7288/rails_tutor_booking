class ProfilesController < ApplicationController
  before_action :set_profile

  def edit
    @profile = current_user.profile
  end

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = Profile.find_by_id(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :user_id)
    end
end
