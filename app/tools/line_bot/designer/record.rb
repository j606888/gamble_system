module LineBot::Designer::Record
  def save_success
    records = @line_source.room.games.last.records
    {
      type: "flex",
      altText: "save_success",
      contents: {
        type: "bubble",
        direction: "ltr",
        header: {
          type: "box",
          layout: 'horizontal',
          contents: [
            {
              type: 'box',
              layout: 'vertical',
              contents: [
                text('儲存成功', { size: 'xl', align: 'center'}),
                text('(已紀錄至Server)', { size: 'sm', margin: 'sm', align: 'center', color: '#ACA6A6'})
              ]
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'box',
              layout: 'vertical',
              flex: 1,
              spacing: 'md',
              contents: [{type: 'spacer'}]
            },
            {
              type: 'box',
              layout: 'vertical',
              flex: 5,
              contents: records.map { |r| record_info(r)}
            },
            {
              type: 'box',
              layout: 'vertical',
              flex: 1,
              spacing: 'md',
              contents: [{type: 'spacer'}]
            }
          ]
        }
      }
    }
  end

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