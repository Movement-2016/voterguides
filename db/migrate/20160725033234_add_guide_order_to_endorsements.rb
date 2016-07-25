class AddGuideOrderToEndorsements < ActiveRecord::Migration[5.0]
  def change
    add_column :endorsements, :guide_order, :integer
    VoterGuide.find_each do |vg|
      vg.endorsements.order(:id).each.with_index do |endorsment, idx|
        endorsment.update_attribute :guide_order_position, idx
      end
    end
    change_column :endorsements, :guide_order, :integer, null: false
  end

  def down
    drop_column :endorsements, :guide_order
  end
end
