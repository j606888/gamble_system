class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    Room.create(rooms_params)
    redirect_to rooms_path
  end

  def show
    @room = Room.find(params[:id])
    @players = @room.players
    @all_records = @room.all_records
  end

  private
  def rooms_params
    params.require(:room).permit(:name, :public)
  end
end