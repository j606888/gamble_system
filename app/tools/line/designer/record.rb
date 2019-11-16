module Line::Designer::Record
  # add_record

  # creating_record(something)
  # record_help
  # record_not_zero(something)
  # record_is_zero(something)
  def add_record(room)
    players = room.players
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
        "type": "bubble",
        "direction": "ltr",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "新增紀錄",
              "size": "xl",
              "align": "center"
            },
            {
              "type": "text",
              "text": "總和為0時會自動儲存",
              "size": "xxs",
              "color": "#9F9F9F"
            },
            {
              "type": "text",
              "text": "輸入或點選「強迫儲存」會無視總結0",
              "size": "xxs",
              "color": "#9F9F9F"
            },
            {
              "type": "text",
              "text": "輸入或點選「取消」會回到主選單",
              "size": "xxs",
              "color": "#9F9F9F"
            }
          ]
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "玩家列表",
                  "align": "center",
                  "weight": "bold"
                },
                {
                  "type": "separator"
                }
              ] + players&.map { |p| player_name_info(p) }
            }
          ]
        },
        "footer": {
          "type": "box",
          "layout": "horizontal",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "postback",
                "label": "強迫儲存",
                "text": "強迫儲存",
                "data": "data: force_save"
              }
            },
            {
              "type": "button",
              "action": {
                "type": "postback",
                "label": "取消",
                "text": "取消",
                "data": "data: ignore"
              }
            }
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
        contents: [
          {
            type: "text",
            text: "教學",
            size: "xxl",
            align: "center"
          }
        ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: "格式： 代號（空格）金額",
            align: "start"
          },
          {
            type: "text",
            text: "備註：可以換行一次輸入多筆",
            size: "xs",
            align: "start",
            color: "#AEA3A3"
          },
          {
            type: "separator",
            margin: "lg"
          },
          {
            type: "text",
            text: "範例：",
            align: "start"
          },
          {
            type: "text",
            text: "J 1200",
            align: "end"
          },
          {
            type: "text",
            text: "L -300",
            align: "end"
          },
          {
            type: "text",
            text: "BOB -300",
            align: "end"
          },
          {
            type: "text",
            text: "BK -600",
            align: "end"
          }
        ]
      }
    }
  end

  def record_not_zero(records_array)
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
            {
              type: "text",
              text: "目前紀錄",
              size: "xl",
              align: "center"
            },
            {
              type: "text",
              text: "(尚未儲存）",
              size: "xs",
              align: "center",
              color: "#ACA6A6"
            }
          ]
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: records_array.map { |r| temp_record_info(r) }
        },
        footer: {
          type: "box",
          layout: "horizontal",
          contents: [
            {
              type: "text",
              text: "請繼續新增紀錄或輸入「強迫儲存」",
              size: "xs",
              align: "center",
              color: "#B9B8B8"
            }
          ]
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
            {
              type: "text",
              text: "儲存成功！",
              size: "xl",
              align: "center"
            },
            {
              type: "text",
              text: "(已紀錄至Server）",
              size: "xs",
              align: "center",
              color: "#ACA6A6"
            }
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
    {
      "type": "text",
      "text": "#{player.name}(#{player.nickname})",
      "align": "center"
    }
  end

  def record_info(record)
    player = record.player
    {
      type: "box",
      layout: "horizontal",
      contents: [
        {
          type: "text",
          text: "#{player.name}(#{player.nickname})"
        },
        {
          type: "text",
          text: record.score.to_s,
          align: "end"
        }
      ]
    }
  end

  def temp_record_info(hash)
    player = Player.find(hash['player_id'])
    score = hash['score']
    {
      type: "box",
      layout: "horizontal",
      contents: [
        {
          type: "text",
          text: "#{player.name}(#{player.nickname})"
        },
        {
          type: "text",
          text: score.to_s,
          align: "end"
        }
      ]
    }
  end
end