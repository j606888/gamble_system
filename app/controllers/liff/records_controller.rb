class Liff::RecordsController < Liff::ApplicationController
  def index
    @players = @source_room.players
    @reports = @players.includes(:records).map(&:analyse)
  end

  def show
    @player = Player.find(params[:player_id])
    @reports = @player.date_report
  end

  def total
    @report = @source_room.report
  end
end