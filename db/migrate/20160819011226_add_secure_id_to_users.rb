class AddSecureIdToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :secure_id, :string, limit: 12
    User.find_each { |u| u.generate_secure_id; u.save }
    add_index :users, :secure_id
    change_column :users, :secure_id, :string, limit: 12, unique: true, null: false
  end

  def down
    remove_index :users, :secure_id
    remove_column :users, :secure_id
  end
end
