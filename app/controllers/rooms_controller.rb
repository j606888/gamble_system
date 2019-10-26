class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_current_room, except: [:index, :new, :create]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    room = Room.create(rooms_params)
    current_user.add_role(:admin, room)
    redirect_to rooms_path
  end
  
  def show
    @players = @room.players.avaliable
    @report = @room.report(record_type)
  end

  def edit
  end

  def update
    @room.update(rooms_params)
    flash[:success] = "更新成功"
    redirect_to @room
  end

  def destroy
    @room.destroy
    flash[:success] = "刪除房間成功"
    redirect_to rooms_path
  end

  def control
    @roles_map = @room.roles_map
    @admin = User.with_role(:admin, @room)
  end

  def join
    if current_user.has_role?(:member, @room)
      flash[:warning] = "你已經在房間內了！"
    else
      current_user.add_role(:member, @room)
      flash[:success] = "加入房間成功！"
    end
    redirect_to @room
  end

  def left
    if current_user.has_role?(:member, @room)
      current_user.remove_role(:member, @room)
      flash[:success] = "退出房間成功！"
    else
      flash[:warning] = "你本來就不在房間內了！"
    end
    redirect_to @room
  end

  private
  def rooms_params
    params.require(:room).permit(:name, :public)
  end

  def record_type
    params[:record_type] || 'winner'
  end

  def set_current_room
    @room = Room.find(params[:id])
  end
end