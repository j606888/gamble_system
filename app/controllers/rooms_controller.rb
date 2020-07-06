class RoomsController < ApplicationController
  def index
    @rooms = Room.includes(:players).all
  end
end