class SampleRoom
  def call
    setup_room!
    setup_player!
    setup_game!
    setup_record!
    @room
  end

  private
  def sample_data
    @sample_date ||= Sample.default
  end
  
  def setup_room!
    @room = Room.create(sample_data[:room])
  end
  
  def setup_player!
    @player_ids = @room.players.create(sample_data[:players]).pluck(:id)
  end

  def setup_game!
    sample_data[:games].map do |recorded_at|
      @room.games.create(recorded_at: recorded_at, user_id: User.first.id)
    end
    @game_ids = @room.games.pluck(:id)
  end

  def setup_record!
    @records_array = sample_data[:records]

    @records_array.each_with_index do |records, t_index|
      game_id = @game_ids[t_index]
      records.each_with_index do |score, i|
        next if score == 0
        player_id = @player_ids[i]
        Record.create(game_id: game_id, player_id: player_id, score: score)
      end
    end
  end
end