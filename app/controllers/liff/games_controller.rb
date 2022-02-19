class Liff::GamesController < Liff::ApplicationController
  def new
    @players = @source_room.players.winner
    @score_array = Player.score_array(@players)
  end

  def create
    records = Record.to_hash(permit_records[:records])
    
    if records[:sum] == 0 || params[:skip_check].present?
      @source_room.games.save_from_array(records[:score_array], params[:gian_count].to_i)
      redirect_to liff_callback_exit_path(message: "紀錄成功")
    else
      @score_array = records[:score_array]
      @gian_count = params[:gian_count]
      @sum = records[:sum]
      render :new
    end
  end

  private
  def permit_records
    params.permit(records: [:player_id, :score])
  end
end