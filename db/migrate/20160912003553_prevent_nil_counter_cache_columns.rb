class PreventNilCounterCacheColumns < ActiveRecord::Migration[5.0]
  def change
    VoterGuide.where(supporters_count: nil).update(supporters_count: 0)
    VoterGuide.where(endorsements_count: nil).update(endorsements_count: 0)
    change_column :voter_guides, :supporters_count, :integer, null: false, default: 0
    change_column :voter_guides, :endorsements_count, :integer, null: false, default: 0
  end
end
