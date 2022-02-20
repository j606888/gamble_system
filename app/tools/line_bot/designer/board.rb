module LineBot::Designer::Board

  def success_saved_board
    {
      type: "flex",
      altText: "記錄成功！",
      contents: {
        type: "carousel",
        contents: [
          last_game_board('儲存成功'),
          score_board
        ]
      }
    }
  end

  def carousel_board
    contents = []
    contents << score_board
    contents << last_game_board('上一戰紀錄') if @line_source.room.games.present?
    contents << setting_board
    {
      type: "flex",
      altText: "麻將說話了",
      contents: {
        type: "carousel",
        contents: contents
      }
    }
  end

  def score_board
    players = @line_source.room.players.winner
    room_name = @line_source.room.name

    return none_user_board if players.count == 0
    {
      type: "bubble",
      header: {
        type: "box",
        layout: "horizontal",
        contents: [
          text(room_name, {flex: 5, size: "xl", align: "start", gravity: "center", color: "#F2B94A", wrap: true} ),
          button_uri("紀錄", @line_source.liff_link('games/new'), {flex: 2, color: "#E1A576", margin: 'none', height: 'sm', style: 'primary'} )
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

  def last_game_board(title)
    players = @line_source.room.players.winner
    return none_user_board if players.count == 0

    game = @line_source.room.games.last
    records = game.records.includes([:player])
    {
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
              text(title, { size: 'xl', align: 'center'}),
              text(@line_source.room.games.last.created_at.strftime("%F %T"), { size: 'sm', margin: 'sm', align: 'center', color: '#ACA6A6'})
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
              button_uri('新增', @line_source.liff_link('players/new'), {color: '#F28C8C', margin: 'md', height: 'sm', style: 'primary'}),
              button_uri('編輯', @line_source.liff_link('players'), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              text('戰績表', {margin: 'md', size: 'lg', align: 'center', gravity: 'center'}),
              button_uri('數據', @line_source.liff_link('records/analyse'), {margin: 'md', height: 'sm', style: 'secondary'}),
              button_uri('表格', @line_source.liff_link('records/total'), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              text('房間', {margin: 'md', size: 'lg', align: 'center', gravity: 'center'}),
              button_uri('更名', @line_source.liff_link('rooms/edit'), {margin: 'md', height: 'sm', style: 'secondary'}),
              button_uri('切換', @line_source.liff_link('rooms/show'), {margin: 'md', height: 'sm', style: 'secondary'})
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
          text('使用教學', { align: 'center', wrap: true} ),
          { type: 'separator' },
          text('1. 至右邊設定新增至少1名玩家', { align: 'start', wrap: true} ),
          text('2. 再次輸入「麻將」', { align: 'start', wrap: true} ),
          text('3. 開始新增紀錄吧！', { align: 'start', wrap: true} )
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
        text(player.name, { margin: "md", flex: 4, align: "start", weight: "bold", wrap: false }),
        text(report[:game_count].to_s, { margin: "sm", flex: 2, align: 'center' }),
        text(report[:total_score].to_s, { align: 'end', flex: 2 })
      ]
    }
  end
end
