class Liff::RoomsController < Liff::ApplicationController
  def create
    room = Room.create(name: params[:name])
    RoomMap.create(room_id: room.id, line_source_id: @line_source.id)
    @line_source.update(room_id: room.id)
    redirect_to liff_callback_exit_path(message: "#{room.name} 建立成功")
  end

  def edit
    @room = @source_room
  end

  def update
    @room = @source_room
    @room.update(name: params[:name])
    redirect_to liff_callback_exit_path(message: "房間更名成功！")
  end

  def show
    @room = @source_room
    @other_rooms = @line_source.other_rooms
  end

  def switch
    @line_source.update(room_id: params[:target_id])
    redirect_to liff_callback_exit_path(message: "切換至 #{@line_source.room.name} 成功！")
  end
end