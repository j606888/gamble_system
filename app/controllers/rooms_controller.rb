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
    @players = @room.players.avaliable
    @headers = @room.header_array(record_type)
    @bodys = @room.body_array(record_type)
    flash[:success] = "Woohoo!"
  end

  private
  def rooms_params
    params.require(:room).permit(:name, :public)
  end

  def record_type
    params[:record_type] || :winner
  end
end