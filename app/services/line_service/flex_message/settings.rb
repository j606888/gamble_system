class LineService::FlexMessage::Settings < Service
  include LiffHelper

  def initialize(room)
    @room = room
  end

  def perform
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
              button_uri('玩家', liff_url('players', @room.id), {color: '#F28C8C', margin: 'md', height: 'sm', style: 'primary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              button_uri('戰績表', liff_url('games', @room.id), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          },{
            type: 'separator'
          },{
            type: 'box',
            layout: 'horizontal',
            contents: [
              button_uri('房間', liff_url('rooms', @room.id), {margin: 'md', height: 'sm', style: 'secondary'})
            ]
          }
        ]
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
