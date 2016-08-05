class AddSupportersCountToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :supporters_count, :integer
  end
end
