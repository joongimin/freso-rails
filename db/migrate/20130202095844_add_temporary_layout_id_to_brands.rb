class AddTemporaryLayoutIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :temporary_layout_id, :integer
    add_index :brands, :temporary_layout_id
  end
end
