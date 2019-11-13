module Line::Reply::Templates::Confirm
  def sample_confirm
    {
      type: 'confirm',
      text: 'Are you sure?',
      actions: [sample_message_action, sample_message_action]
    }
  end

  def left_room_check_confirm
    {
      type: 'confirm',
      text: '確定要解除綁定房間？',
      actions: [left_room_postback, nothing_message]
    }
  end
  
end