class AddRecommendedAtToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :recommended_at, :timestamp
    add_index :voter_guides, :recommended_at
  end
end
