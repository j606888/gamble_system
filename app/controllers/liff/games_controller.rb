class Liff::GamesController < Liff::ApplicationController
  def new
    @players = @source_room.players.avaliable
    @liff_id = Setting.liff_ids.game_new
  end

  def output
    @liff_id = Setting.liff_ids.game_new
    message = Record.to_message(params[:records])
    redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.game_new)
  end
end