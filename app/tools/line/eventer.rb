class Line::Eventer < ServiceCaller
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

    return unbind_detect! if @line_source.unbind_mode?
    return player_detect! if @line_source.player_mode?
    return normal_detact! if @line_source.normal_mode?
    return record_detact! if @line_source.record_mode?
  end

  private

  def line_replyer
    @line_replyer ||= Line::Replyer.new(@reply_token)
  end

  def auto_create_room
    room = Room.create(name: "麻將小房間")
    @line_source.room = room
    @line_source.save
  end

  def setup_line_source!
    source_type = @source['type']
    source_id = @source["#{source_type}Id"]
    @line_source = LineSource.find_or_initialize_by(source_type: "is_#{source_type}", source_id: source_id)
    auto_create_room if @line_source.new_record?
    @room = @line_source.room
    @line_source
  end

  def message_is_text?
    return false unless @message['type'] == ALLOW_MESSAGE_TYPE
    @text = @message['text'].upcase.strip
    true
  end

  def unbind_detect!
    if @text == KEYWORDS[:create_new_room]
      room = Room.create(name: "麻將小房間")
      @line_source.update!(room_id: room.id)
      @line_source.player_mode!
      return line_replyer.reply(:add_player)
    elsif room = Room.find_by(invite_code: @text)
      @line_source.update!(room_id: room.id)
      @line_source.normal_mode!
      return line_replyer.reply(:carousel_board, room)
    end
    
    line_replyer.reply(:need_to_bind_room)
  end

  def player_detect!
    if @text == KEYWORDS[:add_player_done]
      @line_source.normal_mode!
      return line_replyer.reply(:carousel_board, @room)
    end

    name, nickname = @text.split(" ")
    @room.players.create(name: name, nickname: nickname)
    line_replyer.reply(:add_player_success, name)
  end

  def normal_detact!
    return line_replyer.reply(:carousel_board, @room) if @text == KEYWORDS[:mahjohn]
    return left_room if @text == KEYWORDS[:left_room]
    if @text == KEYWORDS[:add_player]
      @line_source.player_mode!
      line_replyer.reply(:add_player)
    elsif @text == KEYWORDS[:add_record]
      @line_source.record_mode!
      line_replyer.reply(:add_record, @room)
    end
  end

  def record_detact!
    records = Rails.cache.fetch("room:#{@room.id}:records") { {} }

    if @text == KEYWORDS[:force_save]
      @room.games.force_from_line(records)
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal_mode!
      return line_replyer.reply(:record_is_zero, @room.games.last)
    elsif @text == KEYWORDS[:force_cancel]
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal_mode!
      return line_replyer.reply(:carousel_board, @room)
    end

    str_records = @text.upcase.strip.split("\n")
    str_records.each do |record|
      nickname, score = record.split(" ")
      player = @room.players.find_by(nickname: nickname) || @room.players.find_by(name: nickname)
      return line_replyer.reply(:player_not_found, nickname) if player.nil?
      records[player.id] = score.to_i
    end
    
    result = @room.games.create_from_line(records)
    if result == :success
      line_replyer.reply(:record_is_zero, @room.games.last)
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal_mode!
    else
      Rails.cache.write("room:#{@room.id}:records", records)
      line_replyer.reply(:record_not_zero, records)
    end
  end

  def left_room
    @line_source.update(room_id: nil)
    @line_source.unbind_mode!
    line_replyer.reply(:need_to_bind_room)
  end  
end