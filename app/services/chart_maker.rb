class ChartMaker
  ALLOW_TYPE = %w[score history]

  def initialize(room)
    @room = room
  end

  def export(type)
    raise "no such type" if ALLOW_TYPE.exclude?(type)
    send("#{type}_chart")
  end

  private
  def history_chart
    dates, player_ids, datasets = Array.new(3) { [] }
    total_score, current_score = Array.new(2) { {} }

    @room.players.avaliable.winner.each_with_index do |player, index|
      player_ids << player.id
      current_score[player.id] = 0
      total_score[player.id] = 0
      datasets << { name: player.name, data: [], color: Colors.order_pick(index, 'random') }
    end

    hash_map = @room.hash_map
    @room.games.each do |game|
      dates << game.date
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
    labels, data, bd_color = Array.new(3) { [] }
    
    @room.players.includes(:records).avaliable.winner.each do |player|
      labels << player.name
      data << player.total_score
    end

    {
      title: "Score Chart",
      labels: labels,
      data: data,
      bg_color: Colors.rgba_array(data),
    }
  end
end