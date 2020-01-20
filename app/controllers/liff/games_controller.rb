class Liff::GamesController < Liff::ApplicationController
  def new
    @players = @source_room.players.avaliable
    @score_array = Player.score_array(@players)
    @liff_id = Setting.liff_ids.game_new
  end

  def output
    @liff_id = Setting.liff_ids.game_new
    records = Record.to_hash(permit_records[:records])
    
    if records[:sum] == 0 || params[:skip_check].present?
      @source_room.games.save_from_array(records[:score_array])
      message = "紀錄成功"
      redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.game_new)
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