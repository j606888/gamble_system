class RemoveNicknameFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :nickname, :string
  end
end
