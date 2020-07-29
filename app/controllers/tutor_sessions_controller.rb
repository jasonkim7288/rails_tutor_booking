class TutorSessionsController < ApplicationController
  before_action :set_tutor_session, only: [:show, :edit, :update, :destroy]

  # GET /tutor_sessions
  def index
    @tutor_sessions = TutorSession.all

  end

  # GET /tutor_sessions/search
  def search_result

  end

  # GET /tutor_sessions/1
  def show
  end

  # GET /tutor_sessions/new
  def new
    @tutor_session = TutorSession.new
    # hide components by adding bootstrap class "d-none" depending on the place
    if @tutor_session.place == "offline"
      @hide_when_offline = "d-none"
      @hide_when_online = ""
    else
      @hide_when_offline = ""
      @hide_when_online = "d-none"
    end
  end

  # GET /tutor_sessions/1/edit
  def edit
  end

  # POST /tutor_sessions
  def create
    @tutor_session = TutorSession.new(tutor_session_params)

    if @tutor_session.save
      redirect_to @tutor_session, notice: 'Tutor session was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tutor_sessions/1
  def update
    if @tutor_session.update(tutor_session_params)
      redirect_to @tutor_session, notice: 'Tutor session was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tutor_sessions/1
  def destroy
    @tutor_session.destroy
    redirect_to tutor_sessions_url, notice: 'Tutor session was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor_session
      @tutor_session = TutorSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutor_session_params
      params.require(:tutor_session).permit(:title, :description, :place, :category, :start_datetime, :end_datetime, :conf_url, :address, :latitude, :longitude, :decimal, :max_students_num, :user_id)
    end
end
