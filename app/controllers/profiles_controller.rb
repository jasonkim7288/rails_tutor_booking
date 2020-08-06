class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :authenticate_user!, only: [:edit, :update]
  load_and_authorize_resource

  def edit
    @profile = current_user.profile
  end

  def update
    # be ready to update by assigning params
    @profile.assign_attributes(profile_params)

    # if using file attachment, set the enum img_type to 1 (:type_picture)
    if @profile.picture.attached?
      @profile.img_type = :type_picture
    else
      @profile.img_type = :type_initial
    end

    if @profile.save
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
      params.require(:profile).permit(:name, :phone_number, :user_id, :about_me, :picture)
    end
end
