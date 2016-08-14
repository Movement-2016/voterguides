class AddSuspendedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :suspended_at, :timestamp
  end
end
