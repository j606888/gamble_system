class PlayersController < ApplicationController
  before_action :set_current_room
  before_action :set_current_player, only: [:edit, :update, :triggle_hidden]

  def index
    @players = @room.players.order(:id)
  end

  def new
    @player = @room.players.new
  end

  def create
    @room.players.create(player_params)
    redirect_to @room
  end

  def edit
  end

  def update
    @player.update(player_params)
    redirect_to room_players_path(@room)
  end

  def triggle_hidden
    @player.update(hidden: !@player.hidden)
    redirect_to room_players_path(@room)
  end

  private
  def player_params
    params.require(:player).permit(:name, :nickname, :room_id, :hidden)
  end

  def set_current_player
    @player = Player.find(params[:id])
  end
end