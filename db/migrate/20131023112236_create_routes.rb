class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :hash_key, limit: 255, null: false
      t.string :url, null: false
      t.datetime :created_at, null: false
    end
  end
end
