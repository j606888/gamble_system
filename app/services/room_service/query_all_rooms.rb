class RoomService::QueryAllRooms < Service
  def initialize; end

  def perform
    rooms = Room.includes(:players, :games).all
    rooms = rooms.sort do |r1, r2|
      r1_created_at = r1.games.last&.created_at
      r2_created_at = r2.games.last&.created_at

      r1_created_at && r2_created_at ? r1_created_at <=> r2_created_at :
      r1_created_at ? 1 : -1
    end.reverse

    rooms
  end
end