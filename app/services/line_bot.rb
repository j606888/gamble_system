class LineBot < ServiceCaller
  def initialize(event)
    @type = event['type']
    @reply_token = event['replyToken']
    @user_id = event['source']['userId']
    @group_id = event['source']['groupId']
    @type = event['source']['type']
    @message_type = event['message']['type']
    @message_text = event['message']['text'].downcase.strip
  end

  def call
    setup_line_group!
    message_eater = MessageEater.call(@line_group, @message_text)
    LineReplyer.call(message_eater.result, @reply_token) if message_eater.success?
  end

  private

  def setup_line_group!
    is_user = @group_id.nil?
    group_id = is_user ? @user_id : @group_id
    @line_group = LineGroup.find_or_create_by(group_id: group_id, is_user: is_user)
  end

  def bind_room?
    @room ||= @line_group.room
    @room.present?
  end
end 