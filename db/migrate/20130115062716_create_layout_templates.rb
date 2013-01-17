class CreateLayoutTemplates < ActiveRecord::Migration
  def change
    create_table :layout_templates do |t|
      t.string :layout_option_template
      t.timestamps
    end
  end
end
