class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :hash_key
      t.text :url

      t.timestamps
    end
  end
end
