class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :zipcode, limit: 5
      t.string :city
      t.string :county
      t.string :state, limit: 2
    end
    add_index :locations, :zipcode
    add_index :locations, :state
  end
end
