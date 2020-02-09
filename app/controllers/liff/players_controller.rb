class Liff::PlayersController < Liff::ApplicationController
  before_action :check_source_ability, only: [:create, :index, :update, :destroy]

  def index
    @players = @room.players.winner
  end

  def new
  end

  def create
    line_source = LineSource.find_by(source_id: params[:source_id])
    room = line_source.room
    @player = room.players.find_by(name: params[:name])
    if @player.present?
      @text = "名稱已被使用！"
      render :new and return
    end
    player = room.players.create(name: params[:name])
    redirect_to liff_callback_exit_path(message: "#{player.name} 建立成功！")
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    player = Player.find(params[:id])
    return render json: { status: 403 } unless player.room = @room
    player.update(player_params)
    redirect_to liff_callback_exit_path(message: "#{player.name} 更新成功！")
  end

  def trigger_hidden
    player = Player.find(params[:id])
    player.update(hidden: !player.hidden)
    status = player.hidden ? '隱藏' : '顯示'
    redirect_to liff_callback_exit_path(message: "#{player.name} #{status} 成功！")
  end

  private
  def check_source_ability    
    @line_source = LineSource.find_by(source_id: params[:source_id])
    return render json: { status: 403 } if @line_source.nil?
    @room = @line_source.room
    return render json: { status: 403 } if @room.nil?
  end

  def player_params
    params.require(:player).permit(:name, :room_id, :hidden)
  end
end