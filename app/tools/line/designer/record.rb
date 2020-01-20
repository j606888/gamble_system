module Line::Designer::Record
  def add_record
    {
      type: "flex",
      altText: "新增紀錄",
      contents: {
        type: "carousel",
        contents: [
          creating_record
        ]
      }
    }
  end

  def creating_record
    players = @line_source.room.players.avaliable.winner
    {
      type: 'bubble',
      header: {
        type: 'box',
        layout: 'horizontal',
        flex: 0,
        contents: [
          text('新增紀錄', {flex: 5, size: 'xl', align: 'start', gravity: 'center', color: '#000000'}),
          button_message('取消', '取消', {flex: 2, color: '#E1A576', margin: 'none', height: 'sm', style: 'primary'})
        ]
      },
      body: {
        type: 'box',
        layout: 'vertical',
        spacing: 'md',
        contents: [
          type: 'box',
          layout: 'vertical',
          contents: [
            text('玩家列表', {align: 'center', weight: 'bold'}),
            { type: 'separator'},
          ] + players&.map { |p| player_name_info(p) }
        ]
      },
      footer: {
        type: "box",
        layout: "vertical",
        contents: [
          button_uri('小幫手', @line_source.liff_link(:game_new), {color: '#E1A576', style: 'primary'})
        ]
      }
    }
  end 

  def record_not_zero
    records_hash = @options[:records_hash]
    sum = 0
    {
      type: "flex",
      altText: "Record not zero",
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
              flex: 4,
              contents: [
                text('目前紀錄', {size: "xl", align: "start"}),
                text('(尚未儲存）', {size: "sm", align: "start", color: "#ACA6A6"})
              ]
            },
            button_message('儲存', '儲存', {flex: 2, color: '#E1A576', margin: 'xxl', height: 'sm', style: 'primary'})
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
              type: "box",
              layout: "vertical",
              flex: 5,
              contents: records_hash.map do |player_id, score|
                sum += score
                temp_record_info(player_id, score)
              end + [
                {
                  type: "separator",
                  margin: "md"
                },
                {
                  type: "box",
                  layout: "horizontal",
                  contents: [
                    text('總結', {weight: 'bold'}),
                    text(sum.to_s, {align: 'end', weight: 'bold'})
                  ]
                }
              ]
            },
            {
              type: 'box',
              layout: 'vertical',
              flex: 1,
              spacing: 'md',
              contents: [{type: 'spacer'}]
            }
          ]
        },
        footer: {
          type: "box",
          layout: "horizontal",
          contents: [ text('請繼續新增紀錄或點選「儲存」', {size: "sm", align: "center", color: "#B9B8B8"} ) ]
        }
      }
    }
  end

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

  def player_name_info(player)
    text("#{player.name}(#{player.nickname})", { align: 'center' })
  end

  def record_info(record)
    player = record.player
    {
      type: "box",
      layout: "horizontal",
      contents: [
        text("#{player.name}(#{player.nickname})"),
        text(record.score.to_s, { align: 'end' })
      ]
    }
  end

  def temp_record_info(player_id, score)
    player = Player.find(player_id)
    {
      type: "box",
      layout: "horizontal",
      contents: [
        text("#{player.name}(#{player.nickname})"),
        text(score.to_s, { align: 'end' })
      ]
    }
  end
end