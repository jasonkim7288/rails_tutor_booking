class TutorSessionsController < ApplicationController
  before_action :set_tutor_session, only: [:show, :edit, :update, :destroy]

  # GET /tutor_sessions
  def index
    @tutor_sessions = TutorSession.all.includes(:user)

  end

  # GET /tutor_sessions/search
  def search_result
    if params[:search_option] == "searching"
      @title = TutorSession.get_searched_title(params[:search_text])
      @tutor_sessions = TutorSession.get_searched_result(params[:search_text])
    else
      @title = TutorSession.get_filtered_title(params[:place], params[:category])
      @tutor_sessions = TutorSession.get_filtered_result(params[:place], params[:category])
    end
  end

  # GET /tutor_sessions/1
  def show
  end

  # GET /tutor_sessions/new
  def new
    @tutor_session = TutorSession.new
    @tutor_session.header_img = "header_img_web_app.png"
  end

  # GET /tutor_sessions/1/edit
  def edit
  end

  # POST /tutor_sessions
  def create
    @tutor_session = TutorSession.new(tutor_session_params)
    @tutor_session.user = current_user

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
      params.require(:tutor_session).permit(:title, :header_img, :description, :place, :category, :start_datetime, :end_datetime, :conf_url, :address, :latitude, :longitude, :max_students_num, :user_id, :picture)
    end
end
