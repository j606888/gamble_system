class Line::Replyer
  REPLY_URI = "https://api.line.me/v2/bot/message/reply"
  ACCESS_TOKEN = Secret.line_api[:access_token]
  ALLOW_ACTION = %i[
    need_to_bind_room
    add_player
    add_player_success
    carousel_board
    add_record
    record_is_zero
    record_not_zero
    player_not_found
  ]
  MAHJOHN_MESSAGE = {
    type: 'text',
    text: '麻將'
  }

  def initialize(reply_token)
    @reply_token = reply_token
  end

  def reply(action, options={})
    raise "not allow action" unless ALLOW_ACTION.include?(action)
    @message_object = line_designer.send(action, options) if options.present?
    @message_object ||= line_designer.send(action)
    post_it
  end

  private
  def line_designer
    @line_designer ||= Line::Designer.new
  end

  def post_it
    conn = Faraday.new(REPLY_URI)
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{ACCESS_TOKEN}"
      request_body = {
        replyToken: @reply_token,
        messages: [@message_object]
      }
      request_body[:messages] << carousel_board(options) if @with_majonh_message = true
      req.body = request_body.to_json
    end
    
  end
end