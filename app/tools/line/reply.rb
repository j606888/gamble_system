class Line::Reply
  include Message::Text
  include Message::Template
  include Message::Flex
  include Message::Quick

  include Templates::Button
  include Templates::Confirm

  include ActionObject::Message
  include ActionObject::Postback
  include ActionObject::Uri

  LINE_URI = "https://api.line.me/v2/bot/message/reply"

  def initialize(reply_token)
    @reply_token = reply_token
  end

  private
  def post_it
    conn = Faraday.new(LINE_URI)
    # request_body
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Line::ACCESS_TOKEN}"
      req.body = request_body.to_json
    end
    
  end

  # https://developers.line.biz/en/reference/messaging-api/#message-objects
  def request_body
    {
      replyToken: @reply_token,
      messages: [@message_object]
    }
  end
end