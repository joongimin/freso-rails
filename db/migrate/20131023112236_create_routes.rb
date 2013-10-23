class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :key
      t.text :url

      t.timestamps
    end
  end
end
