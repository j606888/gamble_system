class LineBot::Eventer < ServiceCaller

  def initialize(event)
    @event = event
    @source = event['source']
    @text = event['message']['text']
  end

  def call
    setup_line_source
    if ['麻將', '德州', '撲克'].include?(@text)
      flex_message = LineService::FlexMessage.new(room_id: @room.id).perform
      res = client.reply_message(@event['replyToken'], flex_message)
    elsif ['上一場', '最後一場'].include?(@text)
      flex_message = LineService::FlexMessage::LastGame.new(room_id: @room.id).perform
      res = client.reply_message(@event['replyToken'], flex_message)
    end
  end

  private

  def setup_line_source
    source_type = @source['type']
    source_id = @source["#{source_type}Id"]
    @line_source = RoomService::SetupLineSource.new(
      source_type: source_type,
      source_id: source_id
    ).perform
    @room = @line_source.room
  end

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_id = ENV['GAMBLE_LINE_CHANNEL_ID']
      config.channel_secret = ENV['GAMBLE_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['GAMBLE_LINE_ACCESS_TOKEN']
    }
  end
end
