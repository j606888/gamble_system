class MessageEater
  attr_accessor :result

  ALLOW_STATUS = %w[normal record remove new]
  SPECIAL_STATUS = %w[new remove normal]
  
  WEB_LINK = "https://j606888.com"

  def self.call(*args)
    service = new(*args)
    service.call
    service
  end

  def initialize(line_group, message)
    @line_group = line_group
    @message = message
    @lock = false
  end

  def call
    setup_group_status!
    send("do_#{@group_status}_action")
  end

  def do_new_action
    return if is_lock?
  end

  def do_remove_action
    @line_group.update(room_id: nil)
    @result = "解除成功！\n請重新綁定或剔除小幫手！"

    Rails.cache.write("room:#{@line_group.id}:status", 'normal')
  end

  def do_normal_action
    try_to_bind_room
    check_room_exist?
    try_to_show_player
  end

  private

  def setup_group_status!
    if SPECIAL_STATUS.include?(@message)
      Rails.cache.write("room:#{@line_group.id}:status", @message)
      @result = "更新狀態：#{@message}"
      lock_it!
    end

    @group_status = Rails.cache.fetch("room:#{@line_group.id}:status") { 'normal' }
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

  def try_to_show_player
    return if is_lock?
    players = @room.players.map { |p| "#{p.name}(#{p.nickname})"}
    @result = players
    lock_it!
  end

  def is_lock?
    @lock == true
  end

  def lock_it!
    @lock = true
  end
end