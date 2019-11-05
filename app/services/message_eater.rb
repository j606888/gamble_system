class MessageEater < ServiceCaller
  SPECIAL_STATUS = {
    "新增" => "new",
    "普通" => "normal"
  }
  WEB_LINK = "http://localhost:3000"

  def initialize(line_group, message)
    @line_group = line_group
    @message = message
  end

  def call
    return if unbind_room?
    return if bind_room?
    return unless room_exist?
    return if room_update_status?

    send("do_#{@group_status}_action")
  end

  def do_normal_action
    @result = case @message
    when '幫助'
      "#{WEB_LINK}/helps"
    when '房間'
      "#{WEB_LINK}/rooms/#{@room.id}"
    when '加入'
      "#{WEB_LINK}/rooms/verify?invite_code=#{@room.invite_code}"
    when '玩家'
      players_array
    else
      "無效"
    end
  end

  def do_new_action
    return @result = players_array if @message == 'player'

    service = GameConverter.call(@room, @message)
    update_room_status('normal') if service.success?
    @result = "記錄模式\n=========\n"
    @result += (service.result || "#{service.error}")
  end

  private

  def unbind_room?
    return false unless @message == 'remove'
    @line_group.update(room_id: nil)
    @result = "解除成功！\n請重新綁定或剔除小幫手！"
    true
  end

  def bind_room?
    room = Room.find_by(invite_code: @message)
    return false if room.nil?

    @line_group.update(room_id: room.id) 
    @result = "綁定房間成功！\n房間名稱：#{room.name}"
    true
  end

  def room_exist?
    @room = @line_group.room
    return true if @room.present?

    @result = "請輸入Invite code綁定房間\n如果沒有房間請先去至網頁版創建\n#{WEB_LINK}"
    false
  end

  def room_update_status?
    @group_status = Rails.cache.fetch("room:#{@room.id}:status") { '一般' }
    return false if SPECIAL_STATUS.keys.exclude?(@message)

    status = SPECIAL_STATUS[@message]
    update_room_status(status)
    Rails.cache.delete("room:#{@room.id}:records")
    if @message == '新增'
      @result = "進入記錄模式\n請輸入戰機"
    elsif @message == '普通'
      @result = "更新狀態：#{@message}"
    end
    true
  end

  def players_array
    @room.players.map { |p| "#{p.name}(#{p.nickname})"}
  end

  def update_room_status(status)
    Rails.cache.write("room:#{@room.id}:status", status)
  end
end