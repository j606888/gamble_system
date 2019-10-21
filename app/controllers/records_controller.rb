class RecordsController < ApplicationController
  def create
    room = Record.fast_create(record_params)
    redirect_to Room.find(params[:room_id])
  end

  private
  def record_params
    params.permit(:room_id, records: [:player_id, :score] )
  end
end