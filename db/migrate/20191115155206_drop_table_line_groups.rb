class DropTableLineGroups < ActiveRecord::Migration[5.2]
  def change
    drop_table :line_groups
  end
end
