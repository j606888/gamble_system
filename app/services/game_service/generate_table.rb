class GameService::GenerateTable < Service
  def initialize room_id:
    @room_id = room_id
  end

  def perform
    room = Room.find_by(id: @room_id)

    {
      players: fetch_player_with_sum(room),
      record_map: fetch_record_map(room)
    }
  end

  private
  def fetch_player_with_sum room
    room.players.joins(:records).
      select("players.*, sum(records.score) as total_score").
      group('players.id').
      order('sum(records.score) desc')
  end

  def fetch_record_map room
    room.games.includes(:records).order(:created_at => :desc).map do |game|
      temp_map = {}
      game.records.each do |record|
        temp_map[record.player_id.to_s] = record.score
      end

      temp_map['date'] = game.created_at.strftime("%F ")
      temp_map
    end
  end
end
