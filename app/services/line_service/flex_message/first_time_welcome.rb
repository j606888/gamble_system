class LineService::FlexMessage::FirstTimeWelcome < Service
  def initialize(room)
    @room = room
  end

  def perform
    next_url = "/liff2/players/new?room_id=#{@room.id}"

    {
      "type": "bubble",
      "direction": "ltr",
      "header": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "text",
            "text": "歡迎使用十一萬",
            "size": "lg",
            "color": "#000000FF",
            "align": "center",
            "contents": []
          },
          {
            "type": "text",
            "text": "先新增幾個玩家來開始使用吧！",
            "align": "center",
            "margin": "md",
            "contents": []
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
              "type": "uri",
              "label": "新增玩家",
              "uri": "https://liff.line.me/1653880740-r34PQk4w?next_url=#{next_url}"
            },
            "style": "primary"
          }
        ]
      }
    }
  end
end