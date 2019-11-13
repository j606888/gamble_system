module Line::Event::Message
  def text
    raise "not message type" unless is_message?
    @message['text'].downcase.strip
  end

  def is_message?
    @type == 'message'
  end
end