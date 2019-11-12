module Line::Event::Source
  def user_id
    @source['userId']
  end

  def group_id
    @source['groupId']
  end

  def room_id
    @source['roomId']
  end

  def is_user?
    @source['type'] == 'user'
  end

  def is_group?
    @source['type'] == 'group'
  end

  def is_room?
    @source['type'] == 'room'
  end
end