class GameConverter < ServiceCaller
  def initialize(room, message)
    @room = room
    @message = message
  end

  def call
    rows = @message.upcase.split("\n")

    
    records_hash = Rails.cache.read("room:#{@room.id}:records") || {}

    rows.each do |row|
      nickname, score = row.split(" ")
      player = @room.players.find_by(nickname: nickname)
      raise("#{nickname} not found") if player.nil?
      raise("#{score} not integer") unless score.to_i.is_a?(Integer)
      records_hash[player.id] = score
    end
    
    cache_records(records_hash)
    records_array = records_hash.map do |key,value|
      {
        'player_id' => key,
        'score' => value
      }
    end
    result = @room.games.fast_create(records_array, "line_bot")
    if result == :success
      @result = "儲存成功"
      Rails.cache.delete("room:#{@room.id}:records")
    else
      @result = result
    end
  end

  def cache_records(records_array)
    Rails.cache.write("room:#{@room.id}:records", records_array)
  end
end