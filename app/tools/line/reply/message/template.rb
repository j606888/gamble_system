module Line::Reply::Message::Template
  # use for adding button 
  # https://developers.line.biz/en/docs/messaging-api/message-types/#template-messages
  # https://developers.line.biz/en/reference/messaging-api/#template-messages

  ALLOW_TEMPLATE_TYPES = %i[bind_first console left_room_check]

  def reply_template(type, room=nil)
    @room = room
    raise "not allow types" unless ALLOW_TEMPLATE_TYPES.include?(type)
    
    @message_object = send("reply_template_for_#{type}")
    post_it
  end

  def reply_template_for_bind_first
    {
      type: 'template',
      altText: '須先綁定房間',
      template: bind_first_button
    }
  end

  def reply_template_for_console
    {
      type: 'template',
      altText: '主控台',
      template: console_button
    }
  end

  def reply_template_for_left_room_check
    {
      type: 'template',
      altText: '離房確認',
      template: left_room_check_confirm
    }
  end

end