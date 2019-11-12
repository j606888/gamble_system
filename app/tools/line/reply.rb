class Line::Reply
  LINE_URI = "https://api.line.me/v2/bot/message/reply"
  

  def initialize(reply_token)
    @reply_token = reply_token
  end

  def post
    conn = Faraday.new(LINE_URI)
    
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Line::ACCESS_TOKEN}"
      req.body = @body.to_json
    end
  end

  def request_body
    {
      replyToken: @reply_token,
      messages: message_objects
    }
  end
end