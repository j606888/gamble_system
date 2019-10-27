class RecordsController < ApplicationController
  before_action :set_current_room
  before_action :check_helper_authorize!

  def create
    respond_to do |format|
      format.html { render :index }
      format.js
    end
    @result = Record.fast_create(record_params)

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