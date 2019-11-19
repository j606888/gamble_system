class CreateLineSources < ActiveRecord::Migration[5.2]
  def change
    create_table :line_sources do |t|
      t.integer :source_type
      t.string :source_id
      t.integer :room_id

      t.timestamps
    end
  end
end
