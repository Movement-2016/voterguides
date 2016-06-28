class CreateVoterGuides < ActiveRecord::Migration[5.0]
  def change
    create_table :voter_guides do |t|
      t.string :name
      t.string :target_city
      t.string :target_state
      t.date :election_date

      t.timestamps
    end
  end
end
