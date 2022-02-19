class RemoveInviteCodeFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :invite_code, :string
  end
end
