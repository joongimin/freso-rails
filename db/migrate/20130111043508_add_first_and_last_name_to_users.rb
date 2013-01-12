class AddFirstAndLastNameToUsers < ActiveRecord::Migration
  def up
    User.create_translation_table!({
      :first_name => {:type => :string, :limit => 20},
      :last_name => {:type => :string, :limit => 20},
      })
  end

  def down
    User.drop_translation_table!
  end
end
