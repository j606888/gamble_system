class LineBot::Receiver < ServiceCaller
  def initialize(request)
    @request = request
  end

  def call
    validate_request
    handle_request
  end

  private

  def validate_request
    @body = @request.body.read
    signature = @request.env['HTTP_X_LINE_SIGNATURE']
    raise 'Bad Request' unless client.validate_signature(@body, signature)
  end

  def handle_request
    events = client.parse_events_from(@body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          LineBot::Eventer.call(event)
        end
      end
    end
  end

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_id = ENV['GAMBLE_LINE_CHANNEL_ID']
      config.channel_secret = ENV['GAMBLE_LINE_CHANNEL_SECRET']
      config.channel_token = ENV['GAMBLE_LINE_ACCESS_TOKEN']
    }
  end
end