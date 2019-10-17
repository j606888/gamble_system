class PlayersController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @player = @room.players.new
  end

  def create
    room = Room.find params[:player][:room_id]
    Player.create(player_params)
    redirect_to room
  end

  private
  def player_params
    params.require(:player).permit(:name, :nickname, :room_id)
  end
end