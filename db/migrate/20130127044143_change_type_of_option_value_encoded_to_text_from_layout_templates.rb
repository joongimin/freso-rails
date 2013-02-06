class ChangeTypeOfOptionValueEncodedToTextFromLayoutTemplates < ActiveRecord::Migration
  def up
    change_column :layout_templates, :option_value_encoded, :text
    change_column :layouts, :option_value_encoded, :text
  end

  def down
    change_column :layout_templates, :option_value_encoded, :string
    change_column :layouts, :option_value_encoded, :string
  end
end
