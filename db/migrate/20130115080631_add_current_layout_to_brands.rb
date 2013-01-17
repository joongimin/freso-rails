class AddCurrentLayoutToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :current_layout_id, :integer
    add_index :brands, :current_layout_id
  end
end
