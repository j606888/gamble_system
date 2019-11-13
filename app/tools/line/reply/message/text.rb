module Line::Reply::Message::Text
  # emoji_list
  # https://developers.line.biz/media/messaging-api/emoji-list.pdf
  ALLOW_TEXT_TYPES = %i[bind_room_success already_bind_room left_room_success]
  
  def reply_text(type)
    raise "not allow types" unless ALLOW_TEXT_TYPES.include?(type)
    @message_object = send("reply_text_for_#{type}")
    post_it
  end

  def reply_text_for_bind_room_success
    {
      type: 'text',
      text: '綁定房間成功！輸入[麻將]叫出主控台'
    }
  end

  def reply_text_for_left_room_success
    {
      type: 'text',
      text: '解除綁定成功！'
    }
  end

  def reply_text_for_already_bind_room
    {
      type: 'text',
      text: '已經有綁定房間了！'
    }
  end

end