class LineSource < ApplicationRecord
  belongs_to :room, optional: true
  has_many :room_maps
  has_many :rooms, through: :room_maps

  enum source_type: [:is_user, :is_group, :is_room]

  def self.setup_up_from(source_type, source_id)
    line_source = self.find_or_create_by(source_type: "is_#{source_type}", source_id: source_id)
    return line_source if line_source.room.present?

    room = Room.create(name: "麻將小房間")
    line_source.update(room_id: room.id)
    RoomMap.create(line_source_id: line_source.id, room_id: line_source.room.id)
    
    line_source
  end
end
