class NotiSettingsController < ApplicationController
  before_action :set_noti_setting
  before_action :authenticate_user!, only: [:edit, :update]

  def edit
    @noti_setting = current_user.noti_setting
  end

  def update
    if @noti_setting.update(noti_setting_params)
      redirect_to root_path, notice: 'Notification settings were successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_noti_setting
      @noti_setting = NotiSetting.includes(:user).find_by_id(params[:id])
    end

    def noti_setting_params
      params.require(:noti_setting).permit(:session_changed, :one_day_to_start, :user_id)
    end
end
