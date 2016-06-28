class CreateEndorsements < ActiveRecord::Migration[5.0]
  def change
    create_table :endorsements do |t|
      t.string :office
      t.string :candidate_name
      t.string :jurisdiction
      t.text :explanation
      t.boolean :highlight
      t.belongs_to :voter_guide, foreign_key: true

      t.timestamps
    end
  end
end
