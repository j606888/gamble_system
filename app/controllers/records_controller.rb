class RecordsController < ApplicationController
  def create
    room = Record.fast_create(record_params)
    redirect_to room
  end

  private
  def record_params
    params.permit(:room_id, records: [:player_id, :score] )
  end
end