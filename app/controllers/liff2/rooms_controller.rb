class Liff2::RoomsController < ApplicationController
  def index
    @room = Room.find_by(id: params.require(:room_id))
    line_source = @room.line_sources.first
    @other_rooms = line_source.rooms - [@room]
  end

  def update
    room = Room.find_by(id: params.require(:id))

    room.update(name: params.require(:name))
    redirect_to liff2_rooms_path(room_id: room.id)
  end

  def change
    room = Room.find_by(id: params.require(:id))
    line_source = room.line_sources.first
    line_source.update(room_id: params.require(:change_id))

    redirect_to liff2_rooms_path(room_id: params.require(:change_id))
  end

  def create
    room = Room.find_by(id: params.require(:current_id))
    line_source = room.line_sources.first

    new_room = Room.create(name: params.require(:name))
    line_source.rooms << [new_room]
    line_source.update(room_id: new_room.id)

    redirect_to liff2_rooms_path(room_id: new_room.id)
  end
end
