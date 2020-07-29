class AddAddressToTutorSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :tutor_sessions, :address, :string
  end
end
