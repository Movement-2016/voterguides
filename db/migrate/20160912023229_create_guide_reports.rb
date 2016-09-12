class CreateGuideReports < ActiveRecord::Migration[5.0]
  def change
    create_table :guide_reports do |t|
      t.text :body
      t.references :voter_guide, foreign_key: true

      t.timestamps
    end
    add_reference :guide_reports, :reporter, references: :users, index: true
    add_foreign_key :guide_reports, :users, column: :reporter_id
  end
end
