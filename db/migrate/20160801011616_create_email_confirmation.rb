class CreateEmailConfirmation < ActiveRecord::Migration[5.0]
  def change
    create_table :email_confirmations do |t|
      t.references :user, foreign_key: true
      t.string :confirmation_code
      t.string :email
      t.timestamp :confirmed_at
    end

    add_index :email_confirmations, [:user_id, :email]
    add_index :email_confirmations, :confirmation_code, unique: true
  end
end
