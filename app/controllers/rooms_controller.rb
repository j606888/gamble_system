class RoomsController < ApplicationController
  def index
    @rooms = RoomService::QueryAllRooms.new.perform
  end

  def show
    @room = Room.find(params[:id])
    @report = @room.report
  end
end