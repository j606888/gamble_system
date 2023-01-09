class LineService::FlexMessage::LastGame < Service
  include LiffHelper

  def initialize(room_id:)
    @room_id = room_id
  end

  def perform
    room = Room.find(@room_id)
    game = room.games.last
    records = game.records.includes([:player]).order(score: :desc)
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
              text("儲存成功", { size: 'xl', align: 'center'}),
              text(game.created_at.strftime("%F %T"), { size: 'sm', margin: 'sm', align: 'center', color: '#ACA6A6'})
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

  def record_info(record)
    player = record.player
    {
      type: "box",
      layout: "horizontal",
      contents: [
        text(player.name),
        text(record.score.to_s, { align: 'end' })
      ]
    }
  end
end
