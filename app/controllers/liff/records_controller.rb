class Liff::RecordsController < Liff::ApplicationController
  def analyse
    @liff_id = Setting.liff_ids.record_analyse
    @players = @source_room.players.avaliable.winner
    @reports = @players.includes(:records).map(&:analyse)
  end

  def single
    @liff_id = Setting.liff_ids.record_analyse
    @player = Player.find(params[:player_id])
    @reports = @player.date_report
  end

  def total
    @liff_id = Setting.liff_ids.record_total
    @report = @source_room.report
  end
end