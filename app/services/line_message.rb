class LineMessage < ServiceCaller
  def initialize(line_event)
    @line_event = line_event

    @reply_token = @line_event.reply_token
    @line_source = @line_event.line_source

    @text = @line_event.text
  end

  def call
    show_console! if @text == '麻將'
  end

  private

  def show_console!
    line_reply.reply_template(:console, @line_event.room)
  end

  def line_reply
    @line_reply ||= Line::Reply.new(@reply_token)
  end
end