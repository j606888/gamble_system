class AddRecorderToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :recorder, :string
  end
end
