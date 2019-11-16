class LineBot < ServiceCaller
  ALLOW_MESSAGE_TYPE = "text"
  KEYWORDS = {
    create_new_room: "建立",
    add_player_done: "結束",
    mahjohn: "麻將",
    left_room: "解除綁定",
    add_player: "新增玩家"
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
  end

  def left_room
    @line_source.update(room_id: nil, status: nil)
    line_replyer.reply(:need_to_bind_room)
  end
end 