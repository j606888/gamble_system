class AddHelperOnToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :helper_on, :boolean, default: true
  end
end
