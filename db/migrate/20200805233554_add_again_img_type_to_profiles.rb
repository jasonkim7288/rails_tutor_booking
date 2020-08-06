class AddAgainImgTypeToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :img_type, :integer, default: 0, null: false
  end
end
