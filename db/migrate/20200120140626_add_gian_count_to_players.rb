class AddGianCountToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :gian_count, :integer, default: 0
  end
end
