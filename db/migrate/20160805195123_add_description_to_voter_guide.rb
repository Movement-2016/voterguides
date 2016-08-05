class AddDescriptionToVoterGuide < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :description, :text
  end
end
