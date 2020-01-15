class CreateRoomMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :room_maps do |t|
      t.integer :line_source_id
      t.integer :room_id

      t.timestamps
    end

    LineSource.all.each do |line_source|
      next if line_source.room.nil?
      RoomMap.create(line_source_id: line_source.id, room_id: line_source.room.id)
    end
  end
end
