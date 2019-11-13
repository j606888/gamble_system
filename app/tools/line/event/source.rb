module Line::Event::Source

  def line_source
    return @line_source if @line_source.present?
    @line_source = LineSource.find_or_create_by(source_type: "is_#{source_type}", source_id: source_id)
  end
  
  def source_type
    @source['type']
  end

  def source_id
    room_id || group_id || user_id
  end

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