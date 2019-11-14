module Line::Designer::Message
  # not_bind_room
  # first_time_new_player
  # create_a_player(name)
  # first_time_finish

  def not_bind_room
    {
      type: "template",
      altText: "this is a buttons template",
      template: {
        type: "buttons",
        actions: [
          {
            type: "postback",
            label: "建立新房間",
            data: {
              action: "create_room"
            }.to_json
          }
        ],
        thumbnailImageUrl: "https://picsum.photos/id/168/300/200",
        title: "尚未綁定房間！",
        text: "如果已有Web版房間請直接輸入「邀請碼」或是點選「建立新房間」"
      }
    }
  end

  def first_time_new_player
    {
      type: "template",
      altText: "this is a buttons template",
      template: {
        type: "buttons",
        actions: [
          {
            type: "message",
            label: "結束",
            text: "結束"
          }
        ],
        thumbnailImageUrl: "https://picsum.photos/id/1025/300/200",
        title: "建立成功，接著來新增點玩家吧",
        text: "輸入玩家的名字！新增完畢後輸入「結束」或點選「結束」鈕。"
      }
    }
  end

  def create_a_player
    {
      type: "text",
      text: "玩家「ABC」建立成功\n繼續新增玩家或輸入「結束」"
    }
  end

  def first_time_finish
    {
      type: "text",
      text: "恭喜你！基本設定已結束\n現在隨時可以輸入「麻將」叫出小幫手了"
    }
  end
end