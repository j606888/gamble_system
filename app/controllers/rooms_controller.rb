class RoomsController < ApplicationController
  before_action :set_current_room, only: [:show, :edit, :update, :left, :chart]
  before_action :check_room_authorize!, only: [:show, :edit, :update, :left, :chart]

  def new
    @room = Room.new
  end

  def create
    room = Room.create(rooms_params)
    current_user.add_role(:member, room)
    redirect_to room
  end

  def sample
    room = SampleRoom.call(current_user).result
    redirect_to room
  end
  
  def show
    @players_analyse = @room.players_analyse
    @players = @room.players.avaliable
  end

  def edit
  end

  def update
    @room.update(rooms_params)
    flash[:success] = "更新成功"
    redirect_to @room
  end

  def join
  end

  def verify
    @room = Room.find_by(invite_code: params[:invite_code])
    if @room.present?
      current_user.add_role(:member, @room)
      flash[:success] = "加入成功！"
      redirect_to @room
    end
  end

  def left
    current_user.remove_role(:member, @room)
    flash[:success] = "退出房間成功！"
    redirect_to @room
  end

  def chart
    @players_analyse = @room.players_analyse
    @score_chart = ChartMaker.new(@room).export('score')
    @history_chart = ChartMaker.new(@room).export('history')
  end

  private
  def rooms_params
    params.require(:room).permit(:name)
  end
end