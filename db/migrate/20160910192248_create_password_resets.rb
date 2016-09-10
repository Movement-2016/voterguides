class CreatePasswordResets < ActiveRecord::Migration[5.0]
  def change
    create_table :password_resets do |t|
      t.references :user, foreign_key: true
      t.string :reset_code
      t.timestamp :reset_at

      t.timestamps
    end
  end
end
