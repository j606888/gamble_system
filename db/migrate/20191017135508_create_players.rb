class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :nickname
      t.integer :room_id

      t.timestamps
    end
  end
end
