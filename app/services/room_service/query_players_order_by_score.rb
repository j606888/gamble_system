class RoomService::QueryPlayersOrderByScore < Service
  def initialize room_id:
    @room_id = room_id
  end

  def perform
    room = Room.find_by(id: @room_id)
    room.
      players.
      left_joins(:records).
      select("players.*", 'SUM(records.score) AS score_sum').
      group("players.id").
      order('score_sum DESC')
  end
end
