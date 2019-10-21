class AddHiddenToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :hidden, :boolean, default: false
  end
end
