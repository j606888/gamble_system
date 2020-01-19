class Admin::RoomsController < Admin::ApplicationController
  def index
    @rooms = Room.includes(:games, :players).all
  end

  def show
    @room = Room.find(params[:id])
    @report = @room.report
  end
end