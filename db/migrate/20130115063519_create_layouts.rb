class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.string :layout_option
      t.integer :brand_id
      t.integer :layout_template_id
      t.timestamps
    end

    add_index :layouts, :brand_id
    add_index :layouts, :layout_template_id
  end
end