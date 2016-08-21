class AddProviderToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    User.find_each { |u| u.update_attributes provider: u.auth_hash['provider']}
    add_index :users, [:provider, :uid], unique: true
  end
end
