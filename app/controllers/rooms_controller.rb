class RoomsController < ApplicationController
  def index
    @rooms = RoomService::QueryAllRooms.new.perform
  end

  def show
    @room = Room.find_by(id: params.require(:id))
    res = GameService::GenerateTable.new(
      room_id: @room.id
    ).perform

    @players = res[:players]
    @record_map = res[:record_map]
  end
end
