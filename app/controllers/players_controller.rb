class PlayersController < ApplicationController
  before_action :set_current_room, except: :create
  before_action :set_current_player, only: [:edit, :update, :triggle_hidden]

  def index
    @players = @room.players.order(:id)
  end

  def new
    @player = @room.players.new
  end

  def create
    room = Room.find params[:player][:room_id]
    Player.create(player_params)
    redirect_to room
  end

  def edit
  end

  def update
    @player.update(player_params)
    redirect_to @room
  end

  def triggle_hidden
    @player.update(hidden: !@player.hidden)
    redirect_to room_players_path(@room)
  end

  private
  def player_params
    params.require(:player).permit(:name, :nickname, :room_id, :hidden)
  end

  def set_current_room
    @room = Room.find(params[:room_id])
  end

  def set_current_player
    @player = Player.find(params[:id])
  end
end