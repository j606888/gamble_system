class RenameColumnOfRooms < ActiveRecord::Migration[5.2]
  def change
    rename_column :rooms, :invite_token, :invite_code
  end
end
