class RemoveDeviseFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :encrypted_password
    remove_column :users, :remember_created_at

    add_column :users, :nuvo_uid, :string
    add_column :users, :nuvo_access_token, :string
    add_column :users, :nuvo_access_token_expires_at, :datetime

    drop_table :authentications
  end

  def down
    add_column :users, :encrypted_password, :string, :null => false, :default => ""
    add_column :users, :remember_created_at, :datetime

    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
    end
    add_index :authentications, :user_id
  end
end
