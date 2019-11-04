class LineReplyer < ServiceCaller
  LINE_URI = "https://api.line.me/v2/bot/message/reply"

  def initialize(result, reply_token)
    @result = result
    @reply_token = reply_token
  end

  def call
    build_body!
    post_it!
  end

  private
  def build_body!
    text = @result.is_a?(Array) ? @result.join("\n") : @result
    @body = {
      replyToken: @reply_token,
      messages: [
        type: 'text',
        text: text
      ]
    }
  end

  def post_it!
    conn = Faraday.new(LINE_URI)
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.line_api[:access_token]}"
      req.body = @body.to_json
    end
  end
end