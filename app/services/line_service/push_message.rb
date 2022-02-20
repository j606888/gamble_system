class LineService::PushMessage < Service
  def initialize room_id:
    @room_id = room_id
  end

  def perform
    room = Room.find(@room_id)
    flex_message = LineService::FlexMessage::LastGame.new(
      room_id: room.id
    ).perform
      
    line_source = room.line_sources.first

    message = {
      type: "flex",
      altText: "麻將說話了",
      contents: {
        type: "carousel",
        contents: [flex_message]
      }
    }
    client.push_message(line_source.source_id, message)
  end

  private
  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_id = ENV['GAMBLE_LINE_CHANNEL_ID']
      config.channel_secret = ENV['GAMBLE_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['GAMBLE_LINE_ACCESS_TOKEN']
    }
  end
end
