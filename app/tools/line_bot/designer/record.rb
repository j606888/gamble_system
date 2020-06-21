module LineBot::Designer::Record
  def record_info(record)
    player = record.player
    {
      type: "box",
      layout: "horizontal",
      contents: [
        text(player.name),
        text(record.score.to_s, { align: 'end' })
      ]
    }
  end
end