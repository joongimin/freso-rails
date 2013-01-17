class CreateImages < ActiveRecord::Migration
	def change
    create_table :images do |t|
      t.string :image
      t.references :imageable, :polymorphic => true
      t.string :environment, :limit => 30
      t.timestamps
    end
  end
end
