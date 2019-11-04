class MessageEater < ServiceCaller
  SPECIAL_STATUS = %w[new remove normal]

  NORMAL_KEY_WORD = %w[help web player join]
  
  WEB_LINK = "http://localhost:3000"

  def initialize(line_group, message)
    @line_group = line_group
    @message = message
    @lock = false
  end

  def call
    setup_group_status!
    send("do_#{@group_status}_action")
  end

  def do_normal_action
    try_to_bind_room
    check_room_exist?
    return if is_lock?
    @result = "無效" && return unless NORMAL_KEY_WORD.include?(@message)
    send("normal_#{@message}_action")
  end

  def do_new_action
    check_room_exist?
    return if is_lock?

    service = GameConverter.call(@room, @message)
    @result = service.error && return unless servicec.success?
    @result = service.result
    update_room_status('normal')
  end

  def do_remove_action
    @line_group.update(room_id: nil)
    @result = "解除成功！\n請重新綁定或剔除小幫手！"

    update_room_status('normal')
  end

  def normal_help_action
    @result = "#{WEB_LINK}/helps"
  end

  def normal_web_action
    @result = "#{WEB_LINK}/rooms/#{@room.id}"
  end

  def normal_join_action
    @result = "#{WEB_LINK}/rooms/verify?invite_code=#{@room.invite_code}"
  end

  def normal_player_action
    players = @room.players.map { |p| "#{p.name}(#{p.nickname})"}
    @result = players
  end

  private

  def setup_group_status!
    @group_status = Rails.cache.fetch("room:#{@line_group.id}:status") { 'normal' }
    return unless SPECIAL_STATUS.include?(@message)

    update_room_status(@message)
    @result = "更新狀態：#{@message}"
    lock_it!
  end

  def try_to_bind_room
    return if is_lock?
    room = Room.find_by(invite_code: @message)
    return if room.nil?
    
    @line_group.update(room_id: room.id) 
    @result = "綁定房間成功！\n房間名稱：#{room.name}"
    lock_it!
  end

  def check_room_exist?
    return if is_lock?
    if @line_group.room.nil?
      @result = "請輸入Invite code綁定房間\n如果沒有房間請先去至網頁版創建\n#{WEB_LINK}"
      lock_it!
    else
      @room = @line_group.room
    end
  end

  def is_lock?
    @lock == true
  end

  def lock_it!
    @lock = true
  end

  def update_room_status(status)
    Rails.cache.write("room:#{@line_group.id}:status", status)
  end
end