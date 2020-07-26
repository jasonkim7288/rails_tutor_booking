class TutorSessionsController < ApplicationController
  before_action :set_tutor_session, only: [:show, :edit, :update, :destroy]
  before_action :set_user_name

  # GET /tutor_sessions
  # GET /tutor_sessions.json
  def index
    @tutor_sessions = TutorSession.all
  end

  # GET /tutor_sessions/1
  # GET /tutor_sessions/1.json
  def show
  end

  # GET /tutor_sessions/new
  def new
    @tutor_session = TutorSession.new
  end

  # GET /tutor_sessions/1/edit
  def edit
  end

  # POST /tutor_sessions
  # POST /tutor_sessions.json
  def create
    @tutor_session = TutorSession.new(tutor_session_params)

    respond_to do |format|
      if @tutor_session.save
        format.html { redirect_to @tutor_session, notice: 'Tutor session was successfully created.' }
        format.json { render :show, status: :created, location: @tutor_session }
      else
        format.html { render :new }
        format.json { render json: @tutor_session.errors, status: :unprocessable_entity }
      end
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
  # DELETE /tutor_sessions/1.json
  def destroy
    @tutor_session.destroy
    respond_to do |format|
      format.html { redirect_to tutor_sessions_url, notice: 'Tutor session was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    # if a user didn't update his or her name, use email for user name. If a user updated, use full name for user name
    def set_user_name
    end
end
