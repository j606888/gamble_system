class Liff2::PlayersController < ApplicationController
  def index
    @room_id = params[:room_id]
    @room = Room.find_by(id: @room_id)
    @players = @room.players.order(created_at: :desc)
  end

  def create
    LiffService::CreatePlayer.new(
      room_id: params[:room_id],
      name: params[:name]
    ).perform
    redirect_to liff2_players_path(room_id: params[:room_id])
  end
end
