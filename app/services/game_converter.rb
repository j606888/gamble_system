class GameConverter
  attr_accessor :result, :error

  def self.call(*args)
    service = self.new(*args)
    service.call
    service
  end

  def initialize(room, message)
    @room = room
    @message = message
  end

  def call
    rows = @message.upcase.split("\n")

    records_array = rows.map do |row|
      nickname, score = row.split(" ")
      player = @room.players.find_by(nickname: nickname)
      raise("#{nickname} not found") if player.nil?
      raise("#{score} not integer") unless score.to_i.is_a?(Integer)
      {
        'player_id' => player.id,
        'score' => score
      }
    end

    result = @room.games.fast_create(records_array, "line_bot")
    if result == :success
      @result = "儲存成功"
    else
      @result = result
    end
  end
end