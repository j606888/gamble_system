class GamesController < ApplicationController
  before_action :set_current_room
  before_action :set_current_game

  def edit
    # only update exist record, no create
  end

  def update
    respond_to do |format|
      format.html
      format.js
    end

    @result = @game.update_by_records(record_params['records'])
    if @result == :success
      flash[:success] = "更新成功"
      redirect_to @room
    end
  end

  def destroy
    @game.destroy
    flash[:success] = "刪除成功"
    redirect_to @room
  end

  private
  def record_params
    params.permit(records: [:player_id, :score])
  end

  def set_current_game
    @game = Game.find(params[:id])
  end
end