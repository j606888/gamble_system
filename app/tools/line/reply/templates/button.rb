module Line::Reply::Templates::Button

  def bind_first_button
    {
      type: 'buttons',
      imageBackgroundColor: '#FFFFFF',
      title: '尚未綁定房間！',
      text: '如果已有Web版房間請直接輸入「邀請碼」或是點選「建立新房間」',
      actions: [create_room_postback]
    }
  end

  def console_button
    {
      type: 'buttons',
      imageBackgroundColor: '#FFFFFF',
      title: '主控台',
      text: '請選擇以下動作',
      actions: [web_room_uri, join_room_uri, left_room_check_postback]
    }
  end
end