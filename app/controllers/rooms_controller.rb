class RoomsController < ApplicationController
  def index
    @rooms = Room.includes(:players).all
  end

  def show
    @room = Room.find(params[:id])
    @report = @room.report
  end
end