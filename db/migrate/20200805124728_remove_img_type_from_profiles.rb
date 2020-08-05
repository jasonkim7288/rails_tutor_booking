class RemoveImgTypeFromProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :img_type, :string
  end
end
