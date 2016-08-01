class AddPublishedAtToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :published_at, :timestamp
    VoterGuide.update_all(published_at: Time.now)
  end
end
