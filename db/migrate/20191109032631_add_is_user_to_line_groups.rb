class AddIsUserToLineGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :line_groups, :is_user, :boolean
  end
end
