module Line::Designer::Board
  # carousel_board

  # main_board
  # score_board(something)
  # unbind_board

  def carousel_board(room)
    invite_code = room.invite_code
    players = room.players.avaliable.winner
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
      type: "bubble",
      direction: "ltr",
      header: {
        type: "box",
        layout: "vertical",
        contents: [ text('主選單', {size: "xl", align: "center", gravity: "center", weight: "regular"}) ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          button_message('新增紀錄', '新增紀錄', {margin: 'xs', height: 'sm', style: 'primary'}),
          button_message('新增玩家', '新增玩家', {margin: 'xs', height: 'sm', style: 'primary'}),
          button_uri('前往web', room.web_link, {margin: 'xs', height: 'sm', style: 'primary'}),
          button_message('查看教學', '還沒啦', {margin: 'xs', height: 'sm', style: 'primary'})
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
          text('總積分', {size: "xl", align: "center", weight: "bold"}),
          text('(更詳細的紀錄請至Web版)', {size: "xs", align: "center", color: "#9F9F9F"}),
          {
            type: "box",
            layout: "horizontal",
            spacing: "xl",
            contents: [
              text('名稱', { margin: "md", align: "start", weight: "bold", color: "#D35400", wrap: false }),
              text('代號', { align: "start", weight: "bold", color: "#D35400" }),
              text('出場數', { margin: "sm", align: "end", weight: "bold", color: "#D35400" }),
              text('總分', { align: "end", weight: "bold", color: "#D35400" })
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
        contents: [ text('解除綁定', { size: 'xl', align: 'center'}) ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          text("邀請碼：#{invite_code}"),
          text("一個群組只能綁定一個麻將群組", { align: 'start'} ),
          text("如果要換新群組請先解除綁定！")
        ]
      },
      footer: {
        type: "box",
        layout: "horizontal",
        contents: [ button_message('解除綁定', '解除綁定') ]
      }
    }
  end

  def player_info(player)
    {
      type: "box",
      layout: "horizontal",
      spacing: "sm",
      contents: [
        text(player.name, { margin: "md", align: "start", weight: "bold", wrap: false }),
        text(player.nickname, { size: "sm", align: "start", color: "#AAAAAA"}),
        text(player.game_times.to_s, { margin: "sm", align: "end" }),
        text(player.total_score.to_s, { aling: 'end' })
      ]
    }
  end
end