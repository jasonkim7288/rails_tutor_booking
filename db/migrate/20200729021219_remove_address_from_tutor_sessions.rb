class RemoveAddressFromTutorSessions < ActiveRecord::Migration[6.0]
  def change
    remove_column :tutor_sessions, :address, :text
  end
end
