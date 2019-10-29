class ChartMaker
  ALLOW_TYPE = %w[score]

  def initialize(room)
    @room = room
  end

  def export(type)
    raise "no such type" if ALLOW_TYPE.exclude?(type)
    send("#{type}_chart")
  end

  private
  def score_chart
    hash = { title: "Score Chart" }
    labels = []
    data = []
    bg_color = []
    bd_color = []
    
    @room.players.includes(:records).each do |player|
      labels << player.name
      data << player.total_score
      bg_color << "#95a5a6"
      # bd_color << "#7f8c8d"
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