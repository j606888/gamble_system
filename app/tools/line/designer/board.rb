module Line::Designer::Board

  def carousel_board
    {
      type: "flex",
      altText: "麻將說話了",
      contents: {
        type: "carousel",
        contents: [
          score_board,
          setting_board
        ]
      }
    }
  end

  def score_board
    players = @line_source.room.players.avaliable.winner
    room_name = @line_source.room.name

    return none_user_board if players.count == 0
    {
      type: "bubble",
      header: {
        type: "box",
        layout: "horizontal",
        contents: [
          text(room_name, {flex: 5, size: "xl", align: "start", gravity: "center", color: "#F2B94A", wrap: true} ),
          button_uri("紀錄", @line_source.liff_link(:game_new), {flex: 2, color: "#E1A576", margin: 'none', height: 'sm', style: 'primary'} )
        ]
      },
      body: {
        type: "box",
        layout: "vertical",
        spacing: "md",
        contents: [
          {
            type: 'box',
            layout: 'horizontal',
            flex: 3,
            spacing: 'xl',
            contents: [
              text('名稱', { flex: 4, margin: 'md', align: 'start', weight: 'bold', color: '#FDCB6E', wrap: false} ),
              text('出場數', { flex: 2, margin: 'sm', align: 'center', weight: 'bold', color: '#FDCB6E'}),
              text('總分', { flex: 2, align: 'end', weight: 'bold', color: '#FDCB6E'})
            ]
          }
        ] + players&.map { |p| player_info(p) }
      }
    }
  end

  def setting_board
    {
      type: 'bubble',
      direction: 'ltr',
      header: {
        type: 'box',
        layout: 'horizontal',
        contents: [
          text('設定', { size: 'xxl', align: 'center' })
        ]
      },
      body: {
        type: 'box',
        layout: 'vertical',
        spacing: 'sm',
        contents: [
          {
            type: 'box',
            layout: 'horizontal',
            contents: [
              text('玩家', {margin: 'md', size: 'lg', align: 'center', gravity: 'center'}),
              button_uri('新增', @line_source.liff_link(:player_new), {color: '#F28C8C', margin: 'md', height: 'sm', style: 'primary'}),
              button_uri('編輯', @line_source.liff_link(:player_edit), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              text('戰績表', {margin: 'md', size: 'lg', align: 'center', gravity: 'center'}),
              button_uri('表格', @line_source.liff_link(:record_total), {margin: 'md', height: 'sm', style: 'secondary'}),
              button_uri('個人', @line_source.liff_link(:record_index), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              text('房間', {margin: 'md', size: 'lg', align: 'center', gravity: 'center'}),
              button_uri('更名', @line_source.liff_link(:room_edit), {margin: 'md', height: 'sm', style: 'secondary'}),
              button_uri('切換', @line_source.liff_link(:room_show), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          }
        ]
      }
    }
  end

  def none_user_board
    {
      type: "bubble",
      direction: 'ltr',
      header: {
        type: "box",
        layout: "vertical",
        contents: [ text("歡迎使用十一萬", {size: "xl", align: 'center'} ) ]
      },
      body: {
        type: "box",
        layout: "vertical",
        spacing: "lg",
        contents: [
          text('目前沒有任何玩家，先到右邊去新增吧。', { align: 'start', wrap: true} ),
          { type: 'separator' },
          text('好了之後再輸入「麻將」叫出我，你就會有一個不一樣的表單了！', { align: 'start', wrap: true} )
        ]
      }
    }
  end

  def player_info(player)
    report = player.analyse
    {
      type: "box",
      layout: "horizontal",
      flex: 1,
      spacing: "sm",
      contents: [
        text("#{player.name}(#{player.nickname})", { margin: "md", flex: 4, align: "start", weight: "bold", wrap: false }),
        text(report[:game_count].to_s, { margin: "sm", flex: 2, align: 'center' }),
        text(report[:total_score].to_s, { align: 'end', flex: 2 })
      ]
    }
  end
end