class AddEmailToPasswordReset < ActiveRecord::Migration[5.0]
  def change
    add_column :password_resets, :email, :string
  end
end
