class RemovePreviewImageFromLayoutTemplate < ActiveRecord::Migration
  def up
  	remove_column :layout_templates, :preview_image
  end
end
