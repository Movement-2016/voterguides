class CreateUnsubscribeOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :unsubscribe_options do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.string :code
      t.timestamp :requested_at

      t.timestamps
    end
    add_index :unsubscribe_options, :email
    add_index :unsubscribe_options, :code
  end
end
