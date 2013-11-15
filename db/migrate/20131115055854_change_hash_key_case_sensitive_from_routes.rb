class ChangeHashKeyCaseSensitiveFromRoutes < ActiveRecord::Migration
  def up
    execute("ALTER TABLE routes MODIFY hash_key varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
  end
end
