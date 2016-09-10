class AddCounterCachesToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :endorsements_count, :integer
    VoterGuide.find_each do |vg|
      VoterGuide.reset_counters(vg.id, :endorsements)
    end
  end
end
