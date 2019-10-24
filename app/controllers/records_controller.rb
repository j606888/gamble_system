class RecordsController < ApplicationController
  def create
    @result = Record.fast_create(record_params)
    respond_to do |format|
      format.html { render :index }
      format.js
    end

    if @result == :success
      redirect_to Room.find(params[:room_id])
      flash[:success] = "記錄成功"
    end
  end

  private
  def record_params
    params.permit(:room_id, records: [:player_id, :score] )
  end
end