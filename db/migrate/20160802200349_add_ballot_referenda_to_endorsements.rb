class AddBallotReferendaToEndorsements < ActiveRecord::Migration[5.0]
  def change
    add_column :endorsements, :initiative, :string
    add_column :endorsements, :recommendation, :boolean
  end
end
