class ChartMaker
  ALLOW_TYPE = %w[score line]

  def initialize(room)
    @room = room
  end

  def export(type)
    raise "no such type" if ALLOW_TYPE.exclude?(type)
    send("#{type}_chart")
  end

  private
  def line_chart
    dates = []
    names = []
    data = []
    player_ids = []
    datasets = []
    total_score = {}
    current_score = {}

    @room.players.avaliable.winner.each_with_index do |player, index|
      names << player.name
      player_ids << player.id
      current_score[player.id] = 0
      total_score[player.id] = 0
      datasets << { name: player.name, data: [], color: Colors.order_pick(index) }
    end

    hash_map = @room.hash_map
    @room.games.each do |game|
      dates << game.display_time
      data = []
      player_ids.each_with_index do |player_id, index|
        current_score[player_id] = hash_map[game.id][player_id] || 0
        total_score[player_id] += current_score[player_id]
        datasets[index][:data] << total_score[player_id]
      end
    end


    {
      dates: dates,
      datasets: datasets
    }
  end

  def score_chart
    hash = { title: "Score Chart" }
    labels = []
    data = []
    bg_color = []
    bd_color = []
    
    @room.players.includes(:records).avaliable.winner.each_with_index do |player, index|
      labels << player.name
      data << player.total_score
      bg_color << Colors.order_pick(index)
    end
    {
      title: "Score Chart",
      labels: labels,
      data: data,
      bg_color: bg_color,
      bd_color: bd_color
    }
  end
end