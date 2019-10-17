class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :score
      t.integer :game_id
      t.integer :player_id

      t.timestamps
    end
  end
end
