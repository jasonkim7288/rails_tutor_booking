class CreateTutorSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :tutor_sessions do |t|
      t.string :title
      t.text :description
      t.string :place
      t.string :category
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :conf_url
      t.text :address
      t.decimal :latitude
      t.string :longitude
      t.string :decimal
      t.integer :max_students_num
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
