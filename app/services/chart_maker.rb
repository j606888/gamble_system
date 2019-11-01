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
      datasets << { name: player.name, data: [], color: Colors.order_pick(index, 'other') }
    end

    hash_map = @room.hash_map
    @room.games.each do |game|
      dates << game.display_time(@room.date_format)
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
    
    @room.players.includes(:records).avaliable.winner.each do |player|
      labels << player.name
      data << player.total_score
    end

    {
      title: "Score Chart",
      labels: labels,
      data: data,
      bg_color: color_format(data),
    }
  end

  def color_format(array)
    blue_string = "rgba(2,119,189 , %p)"
    red_string = "rgba(255,61,0 , %p)"
    result = []

    win_array = array.select { |n| n >= 0 }
    lose_array = array.select { |n| n < 0 }

    win_percent = 1.0 / win_array.count
    lose_percent = 1.0 / lose_array.count

    start = 1
    win_array.each do |n|
      result << blue_string.sub("%p", start.to_s)
      start -= win_percent
    end

    start = 0
    lose_array.each do |n|
      start += lose_percent
      result << red_string.gsub("%p", start.to_s)
    end
      
    result
  end
end