class AddAuthorIdToVoterGuides < ActiveRecord::Migration[5.0]
  def change
    add_reference :voter_guides, :author, foreign_key: {to_table: :users}, index: true
  end
end
