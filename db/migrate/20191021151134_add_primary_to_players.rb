class AddPrimaryToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :primary, :boolean
  end
end
