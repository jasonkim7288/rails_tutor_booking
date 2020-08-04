class TutorSessionsController < ApplicationController
  before_action :set_tutor_session, only: [:show, :edit, :update, :destroy, :attend, :cancel_attend]
  before_action :authenticate_user!, only: [:attend, :cancel_attend, :new, :my_attend_list, :my_tutor_sessions]
  load_and_authorize_resource

  # GET /tutor_sessions
  def index
    @tutor_sessions = TutorSession.all.order("created_at DESC").includes(:user)
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
    @comment = @tutor_session.comments.new
    @comments = @tutor_session.comments.order("created_at DESC").includes(:user)
    @attending = false
    if user_signed_in? && @tutor_session.attendances.where(user_id: current_user.id) != []
      @attending = true
    end
    @remained_seats = @tutor_session.max_students_num - @tutor_session.attendances.length
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

  # when a student hit attend
  def attend
    if Attendance.find(tutor_session_id: @tutor_session.id, user_id: current_user.id)
      redirect_to @tutor_session, notice: 'You have already booked this tutor session.'
    elsif current_user.id == @tutor_session.user_id
      redirect_to @tutor_session, notice: 'The tutor cannot book the own tutor session.'
    else
      if Attendance.create(tutor_session: @tutor_session, user: current_user)
        redirect_to @tutor_session, notice: 'You are attending this tutor session.'
      else
        redirect_to @tutor_session, alert: 'Something wrong with attendance. Please contact the site manager'
      end
    end
  end

  # when a student cancel the attendance
  def cancel_attend
    attendance = @tutor_session.attendances.find_by(user_id: current_user.id)
    if attendance
      attendance.destroy
      redirect_to @tutor_session, notice: 'Attending this Tutor session has been canceled.'
    else
      redirect_to @tutor_session, notice: 'You haven\'t attended this Tutor session'
    end
  end

  # show my attend list
  def my_attend_list
    # use map method to solve the N+1 queries
    @tutor_sessions = current_user.attendances.order(created_at: :desc).includes(:tutor_sessions).map {|attendence| attendence.tutor_session}
  end

  def my_tutor_sessions
    @tutor_sessions = current_user.tutor_sessions.order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor_session
      # removed N+1 queries by including all related comments, users, profiles
      @tutor_session = TutorSession.includes(comments: {user: :profile}).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutor_session_params
      params.require(:tutor_session).permit(:title, :header_img, :description, :place, :category, :start_datetime, :end_datetime, :conf_url, :address, :latitude, :longitude, :max_students_num, :user_id, :picture)
    end
end
