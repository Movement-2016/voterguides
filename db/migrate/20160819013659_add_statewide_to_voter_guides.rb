class AddStatewideToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :statewide, :boolean
  end
end
