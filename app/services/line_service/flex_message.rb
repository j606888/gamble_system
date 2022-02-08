class LineService::FlexMessage < Service
  def initialize(room_id:)
    @room_id = room_id
  end

  def perform
    room = query_room!(@room_id)
    contents = [FirstTimeWelcome.new(room).perform]

    {
      type: "flex",
      altText: "麻將說話了",
      contents: {
        type: "carousel",
        contents: contents
      }
    }
  end

  private
  def query_room! room_id
    room = Room.find_by(id: room_id)
    if room.nil?
      raise Service::PerformFailed, "Room not found"
    end

    room
  end
end