class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    Room.create(rooms_params)
    redirect_to rooms_path
  end
  
  def show
    @room = Room.find(params[:id])
    @players = @room.players.avaliable
    @report = @room.report(record_type)
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @room.update(rooms_params)
    flash[:success] = "更新成功"
    redirect_to @room
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:success] = "刪除房間成功"
    redirect_to rooms_path
  end

  private
  def rooms_params
    params.require(:room).permit(:name, :public)
  end

  def record_type
    params[:record_type] || 'winner'
  end
end