class CreateAuthentications < ActiveRecord::Migration
  def up
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.timestamps
    end

    add_index :authentications, :user_id
  end

  def down
    drop_table :authentications
  end
end
