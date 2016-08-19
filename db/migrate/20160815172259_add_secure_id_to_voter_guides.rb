class AddSecureIdToVoterGuides < ActiveRecord::Migration[5.0]
  def up
    add_column :voter_guides, :secure_id, :string, limit: 12
    VoterGuide.find_each { |vg| vg.generate_secure_id; vg.save }
    add_index :voter_guides, :secure_id
    change_column :voter_guides, :secure_id, :string, limit: 12, unique: true, null: false
  end

  def down
    remove_index :voter_guides, :secure_id
    remove_column :voter_guides, :secure_id
  end
end
