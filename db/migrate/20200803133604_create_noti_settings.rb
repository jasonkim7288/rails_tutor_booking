class CreateNotiSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :noti_settings do |t|
      t.boolean :session_changed, null: false
      t.boolean :one_day_to_start, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
