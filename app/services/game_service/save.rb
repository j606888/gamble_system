class GameService::Save < Service
  def initialize room_id:, records:, skip_check: false
    @room_id = room_id
    @records = records
    @skip_check = skip_check
  end

  def perform
    room = query_room!(@room_id)
    sum = calculate_sum(@records)
    if sum != 0 && !skip_check
      raise Service::PerformFailed, "Sum not zero"
    end

    ActiveRecord::Base.transaction do
      game = Game.create!(room: room)
      @records.each do |record|
        next is record[:score].nil?
        player = query_player!(record[:player_id])
        player.update!(gian_count: player.gian_count + gian_count)
        Record.create!(
          game: game,
          player: player,
          score: record[:score]
        )
      end
    end
  end

  private
  def query_room! room_id
    room = Room.find_by(id: room_id)
    if room.nil?
      raise Service::PerformFailed, "Room with room_id `#{room_id}` not found"
    end

    room
  end

  def calculate_sum records
    records
      .map { |record| record[:score] }
      .compact
      .sum
  end

  def query_player! player_id
    player = Player.find_by(id: player_id)
    if player.nil?
      raise Service::PerformFailed, "Player with player_id `#{player_id}` not found"
    end

    player
  end
end