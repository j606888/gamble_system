module Line::Reply::ActionObject::Uri
  def sample_uri
    {  
      type: "uri",
      label: "View details",
      uri: "http://j606888.com:3004",
    }
  end

  def web_room_uri
    {
      type: "uri",
      label: "前往Web",
      uri: "https://j606888.com:3004/rooms/#{@room.id}"
    }
  end

  def join_room_uri
    {
      type: "uri",
      label: "加入房間",
      uri: "https://j606888.com:3004/rooms/verify?invite_code=#{@room.invite_code}"
    }
  end
end