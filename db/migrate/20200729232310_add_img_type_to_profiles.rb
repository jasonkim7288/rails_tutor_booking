class AddImgTypeToProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :image_type, :string
    add_column :profiles, :img_type, :string
  end
end
