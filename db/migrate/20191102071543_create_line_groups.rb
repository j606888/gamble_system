class CreateLineGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :line_groups do |t|
      t.string :group_id
      t.string :room_id

      t.timestamps
    end
  end
end
