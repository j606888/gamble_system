class LineReplyer < ServiceCaller
  LINE_URI = "https://api.line.me/v2/bot/message/reply"

  def initialize(result, reply_token)
    @result = result
    @reply_token = reply_token
  end

  def call
    build_body!
    post_it!
  end

  private
  def build_body!
    text = @result.is_a?(Array) ? @result.join("\n") : @result
    @body = {
      replyToken: @reply_token,
      # messages: [
      #   type: 'text',
      #   text: text
      # ]
      messages: [
        {
          type: 'flex',
          altText: 'This is Flex Message',
          contents: carousel
        }
        
      ]
    }
  end

  def post_it!
    conn = Faraday.new(LINE_URI)
    
    conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Secret.line_api[:access_token]}"
      req.body = @body.to_json
    end
  end

  def carousel
    {
      "type": "carousel",
      "contents": [
        other_flex,
        flex_message,
        flex_message
      ]
    }
  end

  def other_flex
    {
  "type": "bubble",
  "hero": {
    "type": "image",
    "url": "https://ithelp.ithome.com.tw/images/ironman/11th/event/kv_event/kv-bg-addfly.png",
    "size": "full",
    "aspectRatio": "20:13",
    "aspectMode": "cover",
    "action": {
      "type": "uri",
      "uri": "http://linecorp.com/"
    },
    "backgroundColor": "#FFFFFF"
  },
  "body": {
    "type": "box",
    "layout": "vertical",
    "contents": [
      {
        "type": "text",
        "text": "Menu",
        "weight": "bold",
        "size": "xl",
        "margin": "md"
      },
      {
        "type": "text",
        "text": "Please select",
        "margin": "md"
      },
      {
        "type": "spacer"
      }
    ],
    "action": {
      "type": "uri",
      "label": "View detail",
      "uri": "http://linecorp.com/",
      "altUri": {
        "desktop": "http://example.com/page/123"
      }
    }
  },
  "footer": {
    "type": "box",
    "layout": "vertical",
    "spacing": "sm",
    "contents": [
      {
        "type": "button",
        "action": {
          "type": "postback",
          "label": "Buy",
          "data": "action=buy&itemid=123"
        },
        "height": "sm"
      },
      {
        "type": "button",
        "action": {
          "type": "message",
          "label": "it 邦幫忙鐵人賽",
          "text": "it 邦幫忙鐵人賽"
        },
        "height": "sm"
      },
      {
        "type": "button",
        "action": {
          "type": "uri",
          "label": "View detail",
          "uri": "https://ithelp.ithome.com.tw/2020ironman"
        },
        "height": "sm"
      }
    ],
    "flex": 0
  },
  "styles": {
    "footer": {
      "separator": true
    }
  }
}
  end

  def flex_message
 {
  "type": "bubble",
  "body": {
    "type": "box",
    "layout": "horizontal",
    "contents": [
      {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "contents": [],
                "size": "xl",
                "wrap": true,
                "text": "功能列表",
                "color": "#ffffff",
                "weight": "bold"
              }
            ],
            "spacing": "sm"
          },
          {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "button",
                "style": "secondary",
                "margin": "xxl",
                "action": {
                  "type": "message",
                  "label": "前往WEB",
                  "text": "web"
                }
              },{
                "type": "button",
                "style": "secondary",
                "margin": "xxl",
                "action": {
                  "type": "message",
                  "label": "加入房間",
                  "text": "join"
                }
              },{
                "type": "button",
                "style": "secondary",
                "margin": "xxl",
                "action": {
                  "type": "message",
                  "label": "幫助",
                  "text": "Help"
                }
              },{
                "type": "button",
                "style": "secondary",
                "margin": "xxl",
                
                "action": {
                  "type": "message",
                  "label": "新增紀錄",
                  "text": "新增紀錄"
                }
              }
            ],
            "paddingAll": "13px",
            "backgroundColor": "#ffffff1A",
            "cornerRadius": "2px",
            "margin": "xl"
          }
        ]
      }
    ],
    "paddingAll": "20px",
    "backgroundColor": "#464F69"
  }
}
  end
end