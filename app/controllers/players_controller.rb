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

  def show
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    @player.update(player_params)
    redirect_to @player.room
  end

  def triggle_hidden
    player = Player.find(params[:id])
    player.update(hidden: !player.hidden)
    redirect_to player.room
  end

  private
  def player_params
    params.require(:player).permit(:name, :nickname, :room_id, :primary)
  end
end