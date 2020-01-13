class Liff::RoomsController < Liff::ApplicationController
  before_action :check_room_ability, only: [:edit, :update]

  def create
    room = Room.create(name: params[:name])
    RoomMap.create(room_id: room.id, line_source_id: @line_source.id)
    @line_source.update(room_id: room.id)
    message = "#{room.name} 建立成功"
    redirect_to liff_callback_text_path(message: message, liff_id: "1653496919-op36eGKE")
  end

  def edit
  end

  def update
    @room.update(name: params[:name])
    message = "#{@room.name} 房間更名成功！"
    redirect_to liff_callback_text_path(message: message, liff_id: "1653496919-op36eGKE")
  end

  def show
    @room = @source_room
    @other_rooms = @line_source.other_rooms
  end

  def switch
    @line_source.update(room_id: params[:target_id])
    message = "切換至 #{@line_source.room.name} 成功！"
    redirect_to liff_callback_text_path(message: message, liff_id: "1653496919-GmW6orDX")
  end

  private
  def check_room_ability
    @room = Room.find(params[:room_id])
    return render json: { status: 403, error_message: 'Insufficient permission for this room'} if @room != @source_room
  end
end