class LineBot
  LINE_URI = "https://api.line.me/v2/bot/message/reply"

  def initialize(event)
    @type = event['type']
    @replyToken = event['replyToken']
    @userId = event['source']['userId']
    @groupId = event['source']['groupId']
    @type = event['source']['type']
    @message_type = event['message']['type']
    @message_text = event['message']['text']
  end

  def call
    reply_it
  end

  def reply_it
    body = {
      replyToken: @replyToken,
      messages: [
        type: @message_type,
        text: @message_text
      ]
    }

    conn = Faraday.new(LINE_URI)
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.line_api[:access_token]}"
      req.body = body.to_json
    end
  end
end 