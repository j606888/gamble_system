class Line::Eventer < ServiceCaller
  ALLOW_MESSAGE_TYPE = "text"
  KEYWORDS = {
    mahjohn: "麻將",
    add_record: "新增紀錄",
    force_save: "儲存",
    force_cancel: "取消"
    save_success: "紀錄成功"
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

    return normal_detact! if @line_source.normal_mode?
    return record_detact! if @line_source.record_mode?
  end

  def setup_line_source!
    source_type = @source['type']
    source_id = @source["#{source_type}Id"]
    @line_source = LineSource.setup_up_from(source_type, source_id)
    @room = @line_source.room
  end

  def message_is_text?
    return false unless @message['type'] == ALLOW_MESSAGE_TYPE
    @text = @message['text'].upcase.strip
    true
  end

  def normal_detact!
    case @text
    when KEYWORDS[:mahjohn]
      line_replyer.reply(:carousel_board)
    when KEYWORDS[:add_record]
      @line_source.record_mode!
      line_replyer.reply(:add_record)
    when KEYWORDS[:save_success]
      line_replyer.reply(:save_success)
    end
  end

  def record_detact!
    records = Rails.cache.fetch("room:#{@room.id}:records") { {} }

    case @text
    when KEYWORDS[:force_save]
      @room.games.force_from_line(records)
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal_mode!
      line_replyer.reply(:record_is_zero)
    when KEYWORDS[:force_cancel]
      Rails.cache.delete("room:#{@room.id}:records")
      @line_source.normal_mode!
      line_replyer.reply(:carousel_board)
    else
      str_records = @text.upcase.strip.split("\n")
      str_records.each do |record|
        nickname, score = record.split(" ")
        player = @room.players.find_by(nickname: nickname) || @room.players.find_by(name: nickname)
        return line_replyer.reply(:player_not_found, {nickname: nickname}) if player.nil?
        records[player.id] = score.to_i
      end
      
      result = @room.games.create_from_line(records)
      if result == :success
        line_replyer.reply(:record_is_zero)
        Rails.cache.delete("room:#{@room.id}:records")
        @line_source.normal_mode!
      else
        Rails.cache.write("room:#{@room.id}:records", records)
        line_replyer.reply(:record_not_zero, {records: records})
      end      
    end
  end

  private

  def line_replyer
    @line_replyer ||= Line::Replyer.new(@line_source, @reply_token)
  end
end