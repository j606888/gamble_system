class LiffService::CreatePlayer < Service
  def initialize room_id:, name:
    @room_id = room_id
    @name = name
  end

  def perform
    room = Room.find_by(id: @room_id)
    player = Player.create!(
      name: @name,
      room: room
    )
    player
  end
end