module Line::Reply::ActionObject::Postback
  def sample_postback_action
    {  
      type: "postback",
      label: "Buy",
      data: {
        name: 'james',
        age: 25
      }.to_json,
      text: "Buy"
    }
  end

  def create_room_postback
    {
      type: 'postback',
      label: '建立新房間',
      data: {
        action: 'create_room'
      }.to_json
    }
  end

  def left_room_check_postback
    {
      type: 'postback',
      label: '解除綁定',
      data: {
        action: 'left_room_check'
      }.to_json
    }
  end

  def left_room_postback
    {
      type: 'postback',
      label: '解除',
      data: {
        action: 'left_room'
      }.to_json,
      text: "我說解除！"
    }
  end
end