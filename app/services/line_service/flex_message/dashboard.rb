class LineService::FlexMessage::Dashboard < Service
  def initialize(room)
    @room = room
  end

  def perform
    players = @room.players
    room_name = @room.name

    return none_user_board if players.count == 0
    {
      type: "bubble",
      header: {
        type: "box",
        layout: "horizontal",
        contents: [
          text(room_name, {flex: 5, size: "xl", align: "start", gravity: "center", color: "#F2B94A", wrap: true} ),
          button_uri("紀錄", "https://liff.line.me/1656907430-GzJdd9Ed/new_game/?room_id=#{@room.id}", {flex: 2, color: "#E1A576", margin: 'none', height: 'sm', style: 'primary'} )
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

  private
  def text(text, options={})
    {
      type: 'text',
      text: text
    }.merge(options)
  end

  def button_uri(label, uri, options={})
    {
      type: 'button',
      action: {
        type: 'uri',
        label: label,
        uri: uri
      }
    }.merge(options)
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
