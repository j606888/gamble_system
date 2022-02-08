class Liff2::PlayersController < ApplicationController
  def new
    @room_id = params[:room_id]
    @room = Room.find_by(id: @room_id)
  end

  def create
    LiffService::CreatePlayer.new(
      room_id: params[:room_id],
      name: params[:name]
    ).perform
    redirect_to new_liff2_player_path(room_id: params[:room_id])
  end
end