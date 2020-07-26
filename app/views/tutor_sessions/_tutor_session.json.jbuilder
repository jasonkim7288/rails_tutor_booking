json.extract! tutor_session, :id, :title, :description, :place, :category, :start_datetime, :end_datetime, :conf_url, :address, :latitude, :longitude, :decimal, :max_students_num, :user_id, :created_at, :updated_at
json.url tutor_session_url(tutor_session, format: :json)
