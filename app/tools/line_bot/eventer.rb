class LineBot::Eventer < ServiceCaller

  def initialize(event)
    @event = event
    @source = event['source']
    @text = event['message']['text']
    # @source = {
    #   "userId" => "U41341df97042681252c3abba7a9ea607",
    #   "type" => "user"
    # }
    # @message = {
    #   "type" => "text",
    #     "id" => "12080951407824",
    #   "text" => "看看去"
    # }
  end

  def call
    setup_line_source
    if @text == '麻將'
      client.reply_message(@event['replyToken'], designer.carousel_board)
    end
  end

  private

  def setup_line_source
    source_type = @source['type']
    source_id = @source["#{source_type}Id"]
    @line_source = LineSource.setup_up_from(source_type, source_id)
    @room = @line_source.room
  end

  def designer
    @designer ||= LineBot::Designer.new(@line_source)
  end

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_id = ENV['GAMBLE_LINE_CHANNEL_ID']
      config.channel_secret = ENV['GAMBLE_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['GAMBLE_LINE_ACCESS_TOKEN']
    }
  end
end