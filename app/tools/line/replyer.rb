class Line::Replyer
  REPLY_URI = "https://api.line.me/v2/bot/message/reply"
  ACCESS_TOKEN = Secret.line_api[:access_token]
  ALLOW_ACTION = %i[
    carousel_board
    save_success
  ]

  def initialize(line_source, reply_token)
    @line_source = line_source
    @reply_token = reply_token
    @with_majonh_message = false
  end

  def reply(action, options={})
    @options = options
    @with_majonh_message = true if action == :save_success
    raise "not allow action" unless ALLOW_ACTION.include?(action)
    @message_object = line_designer.send(action)
    post_it
  end

  private
  def line_designer
    @line_designer ||= Line::Designer.new(@line_source, @options)
  end

  def post_it
    conn = Faraday.new(REPLY_URI)
    request = conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{ACCESS_TOKEN}"
      request_body = {
        replyToken: @reply_token,
        messages: [@message_object]
      }
      request_body[:messages] << line_designer.carousel_board if @with_majonh_message == true
      req.body = request_body.to_json
    end

    puts request unless request.status == 200
  end
end