class Liff::GamesController < Liff::ApplicationController
  before_action :check_source_ability

  def new
    @players = @room.players
    @liff_id = Setting.liff_ids.game_new
  end

  def output
    @liff_id = Setting.liff_ids.game_new
    message = Record.to_message(params[:records])
    redirect_to liff_callback_text_path(message: message, liff_id: Setting.liff_ids.game_new)
  end

  private
  def check_source_ability    
    @line_source = LineSource.find_by(source_id: params[:source_id])
    return render json: { status: 403 } if @line_source.nil?
    @room = @line_source.room
    return render json: { status: 403 } if @room.nil?
  end
end