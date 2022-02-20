class RoomService::SetupLineSource < Service
  def initialize source_type:, source_id:
    @source_type = source_type
    @source_id = source_id
  end

  def perform
    line_source = LineSource.find_or_create_by(
      source_type: "is_#{@source_type}",
      source_id: @source_id
    )

    if line_source.room.present?
      return line_source
    end

    ActiveRecord::Base.transaction do
      room = Room.create(name: "麻將小房間")
      line_source.update(room_id: room.id)
      RoomMap.create(
        line_source: line_source,
        room: room
      )
    end

    line_source
  end
end
