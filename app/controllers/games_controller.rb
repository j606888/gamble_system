class GamesController < ApplicationController
  before_action :set_current_room
  before_action :set_current_game, except: [:index, :create, :to_csv]

  def index
    @report = @room.report(record_type, params[:edit])
    @players_analyse_array = @room.players_analyse_array
    @score_chart = ChartMaker.new(@room).export('score')
    @history_chart = ChartMaker.new(@room).export('history')
  end

  def edit
  end

  def create
    @result = @room.games.create_with_records(record_params, current_user.email)
    return unless @result == :success

    flash[:success] = "記錄成功"
    redirect_to Room.find(params[:room_id])
  end

  def update
    @result = @game.update_by_records(record_params['records'])
    return unless @result == :success
    
    flash[:success] = "更新成功"
    redirect_to room_games_path(@room)
  end

  def destroy
    @game.destroy
    flash[:success] = "刪除成功"
    redirect_to room_games_path(@room)
  end

  def to_csv
    send_data CsvBuilder.call(@room).result, filename: "#{@room.name}紀錄.csv"
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