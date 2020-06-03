module LineBot::Designer::Element
  def button_message(label, text, options={})
    {
      type: 'button',
      action: {
        type: 'message',
        label: label,
        text: text
      }
    }.merge(options)
  end

  def button_uri(label, uri, options={})
    {
      type: 'button',
      action: {
        type: 'uri',
        label: label,
        uri: uri
      }
    }.merge(options)
  end

  def text(text, options={})
    {
      type: 'text',
      text: text
    }.merge(options)
  end
end