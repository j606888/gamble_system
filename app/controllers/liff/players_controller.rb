class Liff::PlayersController < Liff::ApplicationController
  before_action :check_source_ability, only: [:create, :index, :update, :destroy]

  def index
    @players = @room.players
  end

  def new
  end

  def create
    line_source = LineSource.find_by(source_id: params[:source_id])
    room = line_source.room
    nickname = params[:nickname].upcase
    player = room.players.create(name: params[:name], nickname: nickname)
    message = "#{player.name}(#{player.nickname}) 建立成功！"
    redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.player_new)
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    player = Player.find(params[:id])
    return render json: { status: 403 } unless player.room = @room
    player.update(player_params)
    message = "#{player.name}(#{player.nickname}) 更新成功！"
    redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.player_edit)
  end

  def destroy
    @player = Player.find(params[:id])
    return render json: { status: 403 } unless @player.room = @room
    @player.delete
    message = "#{@player.name} 刪除成功！"
    redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.player_edit)
  end

  private
  def check_source_ability    
    @line_source = LineSource.find_by(source_id: params[:source_id])
    return render json: { status: 403 } if @line_source.nil?
    @room = @line_source.room
    return render json: { status: 403 } if @room.nil?
  end

  def player_params
    params.require(:player).permit(:name, :nickname, :room_id, :hidden)
  end
end