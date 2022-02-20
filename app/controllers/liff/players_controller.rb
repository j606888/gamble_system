class Liff::PlayersController < LiffController
  def index
    @room_id = params[:room_id]
    @room = Room.find_by(id: @room_id)
    @players = @room.players.order(created_at: :desc)
  end

  def create
    LiffService::CreatePlayer.new(
      room_id: params[:room_id],
      name: params[:name]
    ).perform
    redirect_to liff_players_path(room_id: params[:room_id])
  end
end
