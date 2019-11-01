class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_room, except: [:index, :create, :new, :join, :verify, :sample]
  before_action :check_admin_authorize!, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @room = Room.new
  end

  def create
    room = Room.create(rooms_params)
    current_user.add_role(:admin, room)
    current_user.add_role(:member, room)
    redirect_to room
  end

  def sample
    room = SampleRoom.new.call
    current_user.add_role(:admin, room)
    current_user.add_role(:member, room)
    redirect_to room
  end
  
  def show
    authorize! :read, @room
    @players = @room.players.avaliable
    # @report = @room.report(record_type)
    @report = @room.recent_report
  end

  def edit
  end

  def update
    @room.update(rooms_params)
    flash[:success] = "更新成功"
    redirect_to @room
  end

  def destroy_protect
  end

  def destroy
    if @room.name == params[:room_name]
      @room.destroy
      flash[:success] = "刪除房間成功"
      redirect_to rooms_path
    end
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

  def users
    @users = User.with_role(:member, @room)
  end

  def chart
    @chart = ChartMaker.new(@room).export('score')
    @line = ChartMaker.new(@room).export('line')
  end

  private
  def rooms_params
    params.require(:room).permit(:name)
  end

  def record_type
    params[:record_type] || 'winner'
  end
end