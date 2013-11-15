class AddIndexForHashKeyToRoutes < ActiveRecord::Migration
  def change
    add_index :routes, :hash_key
  end
end
