class Admin::RoomsController < Admin::ApplicationController
  def index
    @rooms = Room.includes(:games, :players).all
  end
end