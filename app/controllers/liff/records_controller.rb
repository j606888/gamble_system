class Liff::RecordsController < Liff::ApplicationController
  def index
    @liff_id = Setting.liff_ids.record_index
    @players = @source_room.players
    @reports = @players.includes(:records).map(&:analyse)
  end

  def show
    @liff_id = Setting.liff_ids.record_index
    @player = Player.find(params[:player_id])
    @reports = @player.date_report
  end

  def total
    @liff_id = Setting.liff_ids.record_total
    @report = @source_room.report
  end
end