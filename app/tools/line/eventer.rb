class Line::Eventer < ServiceCaller
  ALLOW_MESSAGE_TYPE = "text"
  KEYWORDS = {
    mahjohn: "麻將",
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
    when KEYWORDS[:save_success]
      line_replyer.reply(:save_success)
    end
  end

  private

  def line_replyer
    @line_replyer ||= Line::Replyer.new(@line_source, @reply_token)
  end
end