module Line::Designer::Message
  # need_to_bind_room
  # add_player
  # add_player_success(name)
  # first_time_finish

  def need_to_bind_room
    {
      "type": "flex",
      "altText": "Flex Message",
      "contents": {
        "type": "bubble",
        "direction": "ltr",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "尚未綁定房間！",
              "size": "lg",
              "align": "center",
              "weight": "bold"
            },
            {
              "type": "text",
              "text": "歡迎使用麻將小幫手，請先建立或綁定房間開始使用",
              "size": "xs",
              "color": "#2F2F2F",
              "wrap": true
            }
          ]
        },
        "footer": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "message",
                "label": "建立新房間",
                "text": "建立"
              },
              "style": "primary"
            },
            {
              "type": "text",
              "text": "或直接輸入房間邀請碼",
              "size": "xxs",
              "align": "center",
              "color": "#9F9F9F"
            }
          ]
        }
      }
    }
  end

  def add_player
    {
      "type": "flex",
      "altText": "Flex Message",
      "contents": {
        "type": "bubble",
        "direction": "ltr",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "新增玩家",
              "size": "lg",
              "align": "center",
              "weight": "bold"
            },
            {
              "type": "text",
              "text": "新增完畢後輸入「結束」或點選「結束」鈕",
              "size": "xs",
              "color": "#2F2F2F",
              "wrap": true
            }
          ]
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "box",
              "layout": "horizontal",
              "contents": [
                {
                  "type": "text",
                  "text": "格式：",
                  "size": "sm",
                  "align": "start",
                  "color": "#9F9F9F",
                  "wrap": true
                },
                {
                  "type": "text",
                  "text": "名稱[空白]暱稱",
                  "size": "sm",
                  "align": "end",
                  "color": "#9F9F9F",
                  "wrap": true
                }
              ]
            },
            {
              "type": "box",
              "layout": "horizontal",
              "contents": [
                {
                  "type": "text",
                  "text": "範例：",
                  "size": "sm",
                  "align": "start",
                  "color": "#9F9F9F",
                  "wrap": true
                },
                {
                  "type": "text",
                  "text": "詹姆士 J",
                  "size": "sm",
                  "align": "end",
                  "color": "#9F9F9F",
                  "wrap": true
                }
              ]
            }
          ]
        },
        "footer": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "message",
                "label": "結束",
                "text": "結束"
              },
              "style": "primary"
            },
            {
              "type": "text",
              "text": "暱稱為空的話會自動建立隨機暱稱",
              "size": "xxs",
              "align": "center",
              "color": "#9F9F9F"
            }
          ]
        }
      }
    }
  end

  def add_player_success(player)
    {
      type: "text",
      text: "玩家「#{player}」建立成功\n繼續新增玩家或輸入「結束」"
    }
  end

  def first_time_finish
    {
      type: "text",
      text: "恭喜你！基本設定已結束\n現在隨時可以輸入「麻將」叫出小幫手了"
    }
  end
end