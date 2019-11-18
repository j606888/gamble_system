module Line::Designer::Record
  def add_record(room)
    players = room.players.avaliable.winner
    {
      type: "flex",
      altText: "新增紀錄",
      contents: {
        type: "carousel",
        contents: [
          creating_record(players),
          record_help
        ]
      }
    }
  end

  def creating_record(players)
     {
        type: "bubble",
        direction: "ltr",
        header: {
          type: "box",
          layout: "vertical",
          contents: [
            text('新增紀錄', { size: "xl", align: "center" }),
            text('總和為0時會自動儲存', { size: "xxs", color: "#9F9F9F" }),
            text('輸入或點選「強迫儲存」會無視總結0', { size: "xxs", color: "#9F9F9F" }),
            text('輸入或點選「取消」會回到主選單', { size: "xxs", color: "#9F9F9F" })
          ]
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "box",
              layout: "vertical",
              contents: [
                text('玩家列表', { align: 'center', weight: 'bold' }),
                { type: "separator" }
              ] + players&.map { |p| player_name_info(p) }
            }
          ]
        },
        footer: {
          type: "box",
          layout: "horizontal",
          contents: [
            button_message('強迫儲存', '強迫儲存'),
            button_message('取消', '取消')
          ]
        }
      }
    
  end

  def record_help
   {
      type: "bubble",
      direction: "ltr",
      header: {
        type: "box",
        layout: "vertical",
        contents: [ text('教學', { size: 'xxl', align: 'center'}) ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          text('格式： 代號（空格）金額', { align: 'start' }),
          text('備註：可以換行一次輸入多筆', { size: "xs", align: "start", color: "#AEA3A3" }),
          { type: "separator", margin: "lg" },
          text('範例', { align: 'start' }),
          text('J 1200', { align: 'end' }),
          text('L -300', { align: 'end' }),
          text('BOB -300', { align: 'end' }),
          text('BK -600', { align: 'end' })
        ]
      }
    }
  end

  def record_not_zero(records_hash)
    {
      type: "flex",
      altText: "Flex Message",
      contents: {
        type: "bubble",
        direction: "ltr",
        header: {
          type: "box",
          layout: "vertical",
          contents: [
            text('目前紀錄', {size: "xl", align: "center"}),
            text('(尚未儲存）', {size: "xs", align: "center", color: "#ACA6A6"})
          ]
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: records_hash.map { |player_id, score| temp_record_info(player_id, score) }
        },
        footer: {
          type: "box",
          layout: "horizontal",
          contents: [ text('請繼續新增紀錄或輸入「強迫儲存」', {size: "xs", align: "center", color: "#B9B8B8"} ) ]
        }
      }
    }
  end

  def record_is_zero(game)
    records = game.records
    {
      type: "flex",
      altText: "Flex Message",
      contents: {
        type: "bubble",
        direction: "ltr",
        header: {
          type: "box",
          layout: "vertical",
          contents: [
            text('儲存成功！', { size: "xl", align: "center" }),
            text('(輸入[麻將]叫出主選單）', { size: "xs", align: "center", color: "#ACA6A6" })
          ]
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: records.map { |r| record_info(r) }
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