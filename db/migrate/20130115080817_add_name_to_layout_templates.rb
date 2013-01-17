class AddNameToLayoutTemplates < ActiveRecord::Migration
  def up
  	LayoutTemplate.create_translation_table!({
  		:name => {:type => :string, :limit => 200},
  		:description => {:type => :string, :limit => 200}
  	})

  	add_column :layout_templates, :preview_image, :string
  	add_column :layout_templates, :user_id, :integer
  	add_index :layout_templates, :user_id
  end

  def down
		remove_index :layout_templates, :user_id
    remove_column :layout_templates, :user_id
    remove_column :layout_templates, :preview_image

  	LayoutTemplate.drop_translation_table!
  end
end