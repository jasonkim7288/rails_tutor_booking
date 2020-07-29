class AddLongitudeToTutorSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :tutor_sessions, :longitude, :decimal
  end
end
