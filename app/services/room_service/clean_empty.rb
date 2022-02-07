class RoomService::CleanEmpty < Service
  def initialize; end

  def perform
    rooms = Room.includes(:players, :games).all
    rooms.each do |room|
      next if room.players.size > 0
      next if room.games.size > 0

      room.destroy
    end
  end
end