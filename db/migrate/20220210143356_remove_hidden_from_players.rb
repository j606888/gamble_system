class RemoveHiddenFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :hidden, :string
  end
end
