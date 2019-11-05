class GameConverter < ServiceCaller
  def initialize(room, message)
    @room = room
    @message = message
  end

  def call
    setup_rows_and_cache!
    push_rows_into_records!
    cache_records!
    make_records_array!
    fast_create!
  end

  private
  def setup_rows_and_cache!
    @rows = @message.upcase.split("\n")
    @records = Rails.cache.read("room:#{@room.id}:records") || {}
  end

  def push_rows_into_records!
    @rows.each do |row|
      nickname, score = row.split(" ")
      player = @room.players.find_by(nickname: nickname)
      raise("#{nickname}玩家不存在！") if player.nil?
      raise("#{score}非整數！") unless score.to_i.is_a?(Integer)
      @records[player.id] = score
    end
  end

  def cache_records!
    Rails.cache.write("room:#{@room.id}:records", @records)
  end

  def make_records_array!
    @records_array = @records.map do |key,value|
      {
        'player_id' => key,
        'score' => value
      }
    end
  end

  def fast_create!
    result = @room.games.fast_create(@records_array, "line_bot")
    if result == :success
      @result = "(儲存成功)"
      Rails.cache.delete("room:#{@room.id}:records")
      @result += player_str
    else
      @error = "(儲存失敗，跟0差了#{result})" + player_str
    end
  end

  def player_str
    str = ""
    @records.each do |key, value|
      str += "\n"
      p = Player.find(key)
      str += "#{p.name} #{value}"
    end
    str
  end
end