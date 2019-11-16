module Line::Designer::Board
  # carousel_board

  # main_board
  # score_board(something)
  # unbind_board

  def carousel_board(room)
    # binding.pry
    invite_code = room.invite_code
    players = room.players
    {
      type: "flex",
      altText: "主控台",
      contents: {
        type: "carousel",
        contents: [
          main_board(room),
          score_board(players),
          unbind_board(invite_code)
        ]
      }
    }
  end

  def main_board(room)
    {
      "type": "bubble",
      "direction": "ltr",
      "header": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "text",
            "text": "主選單",
            "size": "xl",
            "align": "center",
            "gravity": "center",
            "weight": "regular"
          }
        ]
      },
      "body": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "button",
            "action": {
              "type": "postback",
              "label": "新增紀錄",
              "data": "status:creating_record"
            },
            "margin": "xs",
            "height": "sm",
            "style": "primary"
          },
          {
            "type": "button",
            "action": {
              "type": "message",
              "label": "新增玩家",
              "text": "新增玩家"
            },
            "margin": "xs",
            "height": "sm",
            "style": "primary"
          },
          {
            "type": "button",
            "action": {
              "type": "uri",
              "label": "前往Web",
              "uri": room.web_link
            },
            "margin": "xs",
            "height": "sm",
            "style": "primary"
          },
          {
            "type": "button",
            "action": {
              "type": "message",
              "label": "查看教學(not yet)",
              "text": "還沒啦"
            },
            "margin": "xs",
            "height": "sm",
            "style": "primary"
          }
        ]
      }
    }
  end

  def score_board(players)
    
    {
      type: "bubble",
      body: {
        type: "box",
        layout: "vertical",
        spacing: "md",
        action: {
          type: "uri",
          label: "Action",
          uri: "https://linecorp.com"
        },
        contents: [
          {
            type: "text",
            text: "總積分",
            size: "xl",
            weight: "bold"
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "xl",
            contents: [
              {
                type: "text",
                text: "名稱",
                margin: "md",
                align: "start",
                weight: "bold",
                color: "#D35400",
                wrap: false
              },
              {
                type: "text",
                text: "代號",
                align: "start",
                weight: "bold",
                color: "#D35400"
              },
              {
                type: "text",
                text: "出場數",
                margin: "sm",
                align: "end",
                weight: "bold",
                color: "#D35400"
              },
              {
                type: "text",
                text: "總分",
                align: "end",
                weight: "bold",
                color: "#D35400"
              }
            ]
          }
        ] + players&.map { |p| player_info(p) }
      }
    }
  end

  def unbind_board(invite_code)
    {
      type: "bubble",
      direction: "ltr",
      header: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: "解除綁定",
            size: "xl",
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
            text: "邀請碼：#{invite_code}",
          },
          {
            type: "text",
            text: "一個群組只能綁定一個麻將群組",
            align: "start"
          },
          {
            type: "text",
            text: "如果要換新群組請先解除綁定！"
          }
        ]
      },
      footer: {
        type: "box",
        layout: "horizontal",
        contents: [
          {
            type: "button",
            action: {
              type: "message",
              label: "解除綁定",
              text: "解除綁定"
            }
          }
        ]
      }
    }
  end

  def player_info(player)
    {
      type: "box",
      layout: "horizontal",
      spacing: "sm",
      contents: [
        {
          type: "text",
          text: player.name,
          margin: "md",
          align: "start",
          weight: "bold",
          wrap: false
        },
        {
          type: "text",
          text: player.nickname,
          size: "sm",
          align: "start",
          color: "#AAAAAA"
        },
        {
          type: "text",
          text: player.game_times.to_s,
          margin: "sm",
          align: "end"
        },
        {
          type: "text",
          text: player.total_score.to_s,
          align: "end"
        }
      ]
    }
  end
end