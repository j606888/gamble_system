class Liff2::GamesController < ApplicationController
  def new
    @room = Room.find_by(id: params[:room_id])
  end

  def create
    GameService::Save.new({
      room_id: params.require(:room_id),
      records: permit_params[:records],
      skip_check: params[:skip_check].present?
    }.compact).perform

    redirect_to room_path(params[:room_id])
  end

  private
  def permit_params
    params.permit(records: [:score, :player_id])
  end
end