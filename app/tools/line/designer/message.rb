module Line::Designer::Message
  # need_to_bind_room
  # add_player
  # first_time_finish

  def need_to_bind_room
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
            text('尚未綁定房間！', { size: "lg", align: "center", weight: "bold" }),
            text('歡迎使用麻將小幫手，請先建立或綁定房間開始使用', { size: "xs", color: "#2F2F2F", wrap: true })
          ]
        },
        footer: {
          type: "box",
          layout: "vertical",
          contents: [
            button_message('建立新房間', '建立', {style: 'primary'}),
            text('或直接輸入房間邀請碼', { size: "xxs", align: "center", color: "#9F9F9F" })
          ]
        }
      }
    }
  end

  def add_player
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
            text('新增玩家', {size: "lg", align: "center", weight: "bold"}),
            text('新增完畢後輸入「結束」或點選「結束」鈕', {size: "xs", color: "#2F2F2F", wrap: true})
          ]
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "box",
              layout: "horizontal",
              contents: [
                text('格式：', {size: "sm", align: "start", color: "#9F9F9F", wrap: true}),
                text('名稱[空白]暱稱', {size: "sm", align: "end", color: "#9F9F9F", wrap: true})
              ]
            },
            {
              type: "box",
              layout: "horizontal",
              contents: [
                text('範例：', {size: "sm", align: "start", color: "#9F9F9F", wrap: true}),
                text('詹姆士 J', {size: "sm", align: "end", color: "#9F9F9F", wrap: true})
              ]
            }
          ]
        },
        footer: {
          type: "box",
          layout: "vertical",
          contents: [
            button_message('結束', '結束', { style: 'primary'}),
            text('暱稱為空的話會自動建立隨機暱稱', { size: "xxs", align: "center", color: "#9F9F9F" })
          ]
        }
      }
    }
  end

  def add_player_success(player)
    text("玩家「#{player}」建立成功\n繼續新增玩家或輸入「結束」")
  end

  def player_not_found(nickname)
    text("暱稱(#{nickname})不存在，請重新確認！")
  end
end