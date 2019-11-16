class LineBot < ServiceCaller
  ALLOW_MESSAGE_TYPE = "text"
  KEYWORDS = {
    create_new_room: "建立",
    add_player_done: "結束",
    mahjohn: "麻將",
    left_room: "解除綁定",
    add_player: "新增玩家",
    add_record: "新增紀錄",
    force_save: "強迫儲存",
    force_cancel: "取消"
  }

  def initialize(event)
    @event = event

    @type = event['type']  # default message
    @source = event['source']
    @message = event['message']
    @reply_token = event['replyToken']
  end

  def call
    setup_line_source!
    return unless message_is_text?
    return try_to_bind_room if @room.nil?
    
    return add_player! if @line_source.first_add_player?
    return normal_detact! if @line_source.normal?
    return record_detact! if @line_source.recording?
  end

  private

  def line_replyer
    @line_replyer ||= LineReplyer.new(@reply_token)
  end

  def setup_line_source!
    source_type = @source['type']
    source_id = @source["#{source_type}Id"]
    @line_source = LineSource.find_or_create_by(source_type: "is_#{source_type}", source_id: source_id)
    @room = @line_source.room
    @line_source
  end

  def message_is_text?
    return false unless @message['type'] == ALLOW_MESSAGE_TYPE
    @text = @message['text'].upcase.strip
    true
  end

  def try_to_bind_room
    room = Room.create(name: "麻將小房間") if @text == KEYWORDS[:create_new_room]
    room ||= Room.find_by(invite_code: @text)

    return line_replyer.reply(:need_to_bind_room) if room.nil?

    @line_source.update!(room_id: room.id)
    @line_source.first_add_player!
    line_replyer.reply(:add_player)
  end

  def add_player!
    if @text == KEYWORDS[:add_player_done]
      @line_source.normal!
      line_replyer.reply(:carousel_board, @room)
    else
      player_info = @text.split(" ")
      name = player_info[0]
      nickname = player_info[1] || "G"
      @room.players.create(name: name, nickname: nickname)
      line_replyer.reply(:add_player_success, name)
    end
  end

  def normal_detact!
    return line_replyer.reply(:carousel_board, @room) if @text == KEYWORDS[:mahjohn]
    return left_room if @text == KEYWORDS[:left_room]
    if @text == KEYWORDS[:add_player]
      @line_source.first_add_player!
      line_replyer.reply(:add_player)
    end
    if @text == KEYWORDS[:add_record]
      @line_source.recording!
      line_replyer.reply(:add_record, @room)
    end
  end

  def record_detact!
    
    records_hash = Rails.cache.fetch("room:#{@room.id}:records") { {} }
    if @text == KEYWORDS[:force_save]
      # @room.games.force_with_records(records_hash)
      # return line_replyer.record_is_zero(@room.games.last)
    elsif @text == KEYWORDS[:force_cancel]
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal!
      return line_replyer.reply(:carousel_board, @room)
    end

    str_records = @text.upcase.strip.split("\n")
    str_records.each do |record|
      nickname, score = record.split(" ")
      player = @room.players.find_by(nickname: nickname)
      return line_replyer.reply(:player_not_found, nickname) if player.nil?
      records_hash[player.id] = score.to_i
    end

    records_array = records_hash.map do |id, score|
      {
        'player_id' => id,
        'score' => score
      }
    end

    
    result = @room.games.create_with_records(records_array, 'line_bot')
    if result == :success
      line_replyer.reply(:record_is_zero, @room.games.last)
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal!
    else
      Rails.cache.write("room:#{@room.id}:records", records_hash)
      
      line_replyer.reply(:record_not_zero, records_array)
    end
  end

  def left_room
    @line_source.update(room_id: nil, status: nil)
    line_replyer.reply(:need_to_bind_room)
  end
end 