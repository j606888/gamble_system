class Liff::GamesController < ApplicationController
  def new
    @room = Room.find_by(id: params[:room_id])
    @players = RoomService::QueryPlayersOrderByScore.new(room_id: @room.id).perform
  end

  def create
    room_id = params.require(:room_id)

    GameService::Save.new({
      room_id: room_id,
      records: permit_params[:records],
      skip_check: params[:skip_check].present?
    }.compact).perform

    LineService::PushMessage.new(
      room_id: room_id
    ).perform

    redirect_to close_window_liff_index_path
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
