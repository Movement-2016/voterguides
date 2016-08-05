class CreateSupporters < ActiveRecord::Migration[5.0]
  def change
    create_table :supporters do |t|
      t.references :user, foreign_key: true
      t.references :voter_guide, foreign_key: true

      t.timestamps
    end
  end
end
