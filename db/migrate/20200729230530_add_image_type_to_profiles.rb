class AddImageTypeToProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :avatar_type, :string
    add_column :profiles, :image_type, :string
  end
end
