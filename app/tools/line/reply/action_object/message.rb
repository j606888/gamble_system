module Line::Reply::ActionObject::Message
  def sample_message_action
    {  
      type: 'message',
      label: 'Yes',
      text: 'It is Yes'
    }
  end

  def nothing_message
    {
      type: 'message',
      label: '沒事',
      text: '大家我耍呆按錯了Sorry'
    }
  end
end