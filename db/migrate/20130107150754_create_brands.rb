class CreateBrands < ActiveRecord::Migration
  def up
    create_table :brands do |t|
      t.integer :uid
      t.integer :hub_type
      t.integer :layout_id
      t.integer :user_id
      t.string :uri
      t.timestamps
    end
    add_index :brands, :layout_id
    add_index :brands, :user_id
    Brand.create_translation_table!({
      :name => {:type => :string, :limit => 30},
    })
  end

  def down
    drop_table :brands
  end
end
