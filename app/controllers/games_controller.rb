class GamesController < ApplicationController
  def create
    
  end

  def edit
    # only update exist record, no create
    @room = Room.find(params[:room_id])
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
    @result = @game.update_by_records(record_params)
    if @result == :success
      flash[:success] = "更新成功"
      redirect_to @game.room
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    @game = Game.find(params[:id])
    @game.destroy
    flash[:success] = "刪除成功"
    redirect_to @room
  end

  private
  def record_params
    params.permit(records: [:player_id, :score])
  end

  
end