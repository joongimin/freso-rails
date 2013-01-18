class RenameHubTypeToHubFromBrands < ActiveRecord::Migration
  def up
    rename_column :brands, :hub_type, :hub
  end

  def down
    rename_column :brands, :hub, :hub_type
  end
end