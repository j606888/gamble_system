class LineBot < ServiceCaller
  def initialize(event)
    @event = event
    # @type = event['type']
    # @reply_token = event['replyToken']
    # @user_id = event['source']['userId']
    # @group_id = event['source']['groupId']
    # @type = event['source']['type']
    # @message_type = event['message']['type']
    # @message_text = event['message']['text'].downcase.strip
  end

  def call
    
    @line_event = Line::Event.new(@event)
    # binding.pry
    @room = @line_event.room
    
    @line_reply = Line::Reply.new(@line_event.reply_token)

    service = LinePostback.call(@line_event) if @line_event.is_postback?
    service = LineMessage.call(@line_event) if @line_event.is_message?

    @line_reply.reply_template(:bind_first) if @room.nil?
    
    # setup_line_group!
    # message_eater = MessageEater.call(@line_group, @message_text)
    # LineReplyer.call(message_eater.result, @reply_token) if message_eater.success?
  end

  private


  def bind_room?
    @room ||= @line_group.room
    @room.present?
  end
end 