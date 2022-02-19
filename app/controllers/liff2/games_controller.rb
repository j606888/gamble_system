class Liff2::GamesController < ApplicationController
  def new
    @room = Room.find_by(id: params[:room_id])
    @players = RoomService::QueryPlayersOrderByScore.new(room_id: @room.id).perform
  end

  def create
    GameService::Save.new({
      room_id: params.require(:room_id),
      records: permit_params[:records],
      skip_check: params[:skip_check].present?
    }.compact).perform

    redirect_to room_path(params[:room_id])
  end

  def index
    res = GameService::GenerateTable.new(
      room_id: params.require(:room_id)
    ).perform

    @players = res[:players]
    @record_map = res[:record_map]
  end

  private
  def permit_params
    params.permit(records: [:score, :player_id])
  end
end
