class LinePostback < ServiceCaller
  def initialize(line_event)
    @line_event = line_event

    @reply_token = @line_event.reply_token
    @line_source = @line_event.line_source
    @data = @line_event.data
    @action = @data['action']
  end

  def call
    create_room_and_bind! if @action == 'create_room'
    left_room_check! if @action == 'left_room_check'
    left_room! if @action == 'left_room'
  end

  private

  def create_room_and_bind!
    
    line_reply.reply_text(:already_bind_room) if @line_source.room.present?
    room = Room.create(name: '麻將小房間')
    @line_source.update(room_id: room.id)
    line_reply.reply_text(:bind_room_success)
  end

  def left_room_check!
    line_reply.reply_template(:left_room_check)
  end

  def left_room!
    @line_source.update(room_id: nil)
    line_reply.reply_text(:left_room_success)
  end

  def line_reply
    @line_reply ||= Line::Reply.new(@reply_token)
  end

end