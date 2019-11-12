module Line::Reply::TextMessage
  # emoji
  # https://developers.line.biz/media/messaging-api/emoji-list.pdf

  def send_text_message(text)
    {
      type: 'text',
      text: text
    }
  end
end