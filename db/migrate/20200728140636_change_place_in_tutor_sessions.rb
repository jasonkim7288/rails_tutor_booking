class ChangePlaceInTutorSessions < ActiveRecord::Migration[6.0]
  def change
    change_column :tutor_sessions, :place, :string, default: "offline"
    change_column :tutor_sessions, :category, :string, default: "web_app"
  end
end
