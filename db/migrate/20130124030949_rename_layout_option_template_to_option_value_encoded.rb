class RenameLayoutOptionTemplateToOptionValueEncoded < ActiveRecord::Migration
  def up
    rename_column :layout_templates, :layout_option_template, :option_value_encoded
    rename_column :layouts, :layout_option, :option_value_encoded
  end

  def down
    rename_column :layout_templates, :option_value_encoded, :layout_option_template
    rename_column :layouts, :option_value_encoded, :layout_option
  end
end