class CreateLayoutSections < ActiveRecord::Migration
  def up
    add_column :layouts, :mustache, :text
    add_column :layout_templates, :mustache, :text

    create_table :layout_sections do |t|
      t.string :key, :limit => 30
      t.text :mustache
      t.references :layout_sectionable, :polymorphic => true
    end
    add_index :layout_sections, :key
    add_index :layout_sections, :layout_sectionable_id
    add_index :layout_sections, :layout_sectionable_type

    create_table :layout_options do |t|
      t.string :key, :limit => 30
      t.string :option_type, :limit => 30
      t.references :layout_section
      t.text :value
    end
    add_index :layout_options, :key
    add_index :layout_options, :layout_section_id
  end

  def down
    remove_column :layouts, :mustache
    remove_column :layout_templates, :mustache
    drop_table :layout_sections
    drop_table :layout_options
  end
end