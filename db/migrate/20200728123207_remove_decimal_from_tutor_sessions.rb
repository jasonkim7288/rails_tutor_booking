class RemoveDecimalFromTutorSessions < ActiveRecord::Migration[6.0]
  def change
    remove_column :tutor_sessions, :decimal, :string
    remove_column :tutor_sessions, :longitude, :string
  end
end
