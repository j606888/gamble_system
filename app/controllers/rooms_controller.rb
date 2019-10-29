class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :join, :verify]
  before_action :set_current_room, except: [:index, :new, :create, :join, :verify]
  before_action :check_admin_authorize!, only: [:edit, :update, :destroy, :control]

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
  
  def show
    authorize! :read, @room
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

  def password
    if current_user.has_role?(:member, @room) || @room.public
      render :js => "window.location = '#{room_path(@room)}'"
    end
  end

  private
  def rooms_params
    params.require(:room).permit(:name, :public)
  end

  def record_type
    params[:record_type] || 'winner'
  end
end