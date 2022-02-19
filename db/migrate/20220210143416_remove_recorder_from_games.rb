class RemoveRecorderFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :recorder, :string
  end
end
