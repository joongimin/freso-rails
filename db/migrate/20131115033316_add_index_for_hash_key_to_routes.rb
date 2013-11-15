class AddIndexForHashKeyToRoutes < ActiveRecord::Migration
  def change
    add_index :routes, :hash_key, unique: true
  end
end
