class Liff::RecordsController < Liff::ApplicationController
  def analyse
    @players = @source_room.players.avaliable
    @reports = @players.includes(:records).winner.map(&:analyse)
  end

  def single
    @player = Player.find(params[:player_id])
    @reports = @player.date_report
  end

  def total
    @report = @source_room.report
  end
end