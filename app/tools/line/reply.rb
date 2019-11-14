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
    de = Line::Designer.new
    
    # binding.pry
    
    # @message_object = de.not_bind_room
    # @message_object = de.first_time_new_player
    # @message_object = de.create_a_player
    # @message_object = de.first_time_finish
    
    @message_object = de.carousel_board
    # @message_object = de.carousel_record
    # @message_object = de.record_not_zero
    # @message_object = de.record_is_zero

    conn = Faraday.new(LINE_URI)
    # request_body
    a = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Line::ACCESS_TOKEN}"
      req.body = request_body.to_json
    end
    # binding.pry
  end

  # https://developers.line.biz/en/reference/messaging-api/#message-objects
  def request_body
    {
      replyToken: @reply_token,
      messages: [@message_object]
    }
  end
end