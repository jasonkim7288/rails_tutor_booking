class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :authenticate_user!, only: [:edit, :update]

  def edit
    @profile = current_user.profile
  end

  def update
    p @profile
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = Profile.includes(:user).find_by_id(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :user_id, :about_me, :picture, :img_type)
    end
end
