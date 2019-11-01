class GamesController < ApplicationController
  before_action :set_current_room
  before_action :set_current_game, except: [:index, :create]

  def index
    @report = @room.report(record_type)
  end

  def edit
  end

  def create
    @result = @room.games.fast_create(record_params, current_user.email)
    if @result == :success
      redirect_to Room.find(params[:room_id])
      flash[:success] = "記錄成功"
    end
  end

  def update
    @result = @game.update_by_records(record_params['records'])
    if @result == :success
      flash[:success] = "更新成功"
      redirect_to room_games_path(@room)
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "刪除成功"
    redirect_to room_games_path(@room)
  end

  private
  def set_current_game
    @game = Game.find(params[:id])
  end

  def record_type
    params[:type] || 'winner'
  end

  def record_params
    params.permit(records: [:player_id, :score])['records']
  end
end