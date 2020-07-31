class AddHeaderImgToTutorSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :tutor_sessions, :header_img, :string
  end
end
