class CreateFaqCategories < ActiveRecord::Migration
  def up
    create_table :faq_categories do |t|
      t.integer :position
      t.timestamps
    end
  end

  def down
    drop_table :faq_categories
  end
end
