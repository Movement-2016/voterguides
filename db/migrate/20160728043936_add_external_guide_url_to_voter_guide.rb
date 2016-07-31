class AddExternalGuideUrlToVoterGuide < ActiveRecord::Migration[5.0]
  def change
    add_column :voter_guides, :external_guide_url, :string
  end
end
