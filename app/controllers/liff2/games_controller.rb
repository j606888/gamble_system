class Liff2::GamesController < ApplicationController
  def new
    @room = Room.find_by(id: params[:room_id])
  end

  def create
    GameService::Save.new({
      room_id: permit_params[:room_id],
      records: permit_params[:records],
      skip_check: permit_params[:skip_check]
    }.compact).perform

    redirect_to room_path(params[:room_id])
  end

  private
  def permit_params
    params.permit(:room_id, :skip_check, records: [:score, :player_id])
  end
end