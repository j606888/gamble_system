module Line::Designer::Board
  # carousel_board

  # main_board
  # score_board(something)
  # unbind_board

  def carousel_board
    {
      type: "flex",
      altText: "主控台",
      contents: {
        type: "carousel",
        contents: [
          main_board,
          score_board,
          unbind_board
        ]
      }
    }
  end

  def main_board
    {
      type: "bubble",
      direction: "ltr",
      header: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: "麻將小幫手",
            size: "xxl",
            align: "center",
            gravity: "center",
            weight: "regular",
            color: "#1A1917"
          }
        ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "button",
            action: {
              type: "uri",
              label: "前往Web",
              uri: "https://j606888.com:3004"
            },
            color: "#D35400",
            margin: "md",
            height: "md",
            style: "primary"
          },
          {
            type: "button",
            action: {
              type: "postback",
              label: "新增紀錄",
              data: "status:creating_record"
            },
            color: "#D35400",
            margin: "sm",
            style: "primary"
          },
          {
            type: "button",
            action: {
              type: "postback",
              label: "新增玩家",
              data: "status: creating_player"
            },
            color: "#D35400",
            margin: "sm",
            style: "primary"
          },
          {
            type: "button",
            action: {
              type: "message",
              label: "查看教學(not yet)",
              text: "還沒啦"
            },
            color: "#D35400",
            margin: "sm",
            style: "primary"
          }
        ]
      }
    }
  end

  def score_board
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
          {
            type: "text",
            text: "總積分",
            size: "xl",
            weight: "bold"
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "xl",
            contents: [
              {
                type: "text",
                text: "名稱",
                margin: "md",
                align: "start",
                weight: "bold",
                color: "#D35400",
                wrap: false
              },
              {
                type: "text",
                text: "代號",
                align: "start",
                weight: "bold",
                color: "#D35400"
              },
              {
                type: "text",
                text: "出場數",
                margin: "sm",
                align: "end",
                weight: "bold",
                color: "#D35400"
              },
              {
                type: "text",
                text: "總分",
                align: "end",
                weight: "bold",
                color: "#D35400"
              }
            ]
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "sm",
            contents: [
              {
                type: "text",
                text: "莊子Ｅ",
                margin: "md",
                align: "start",
                weight: "bold",
                wrap: false
              },
              {
                type: "text",
                text: "(E)",
                size: "sm",
                align: "start",
                color: "#AAAAAA"
              },
              {
                type: "text",
                text: "22",
                margin: "sm",
                align: "end"
              },
              {
                type: "text",
                text: "-2400",
                align: "end"
              }
            ]
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "sm",
            contents: [
              {
                type: "text",
                text: "李彥增",
                margin: "md",
                align: "start",
                weight: "bold",
                wrap: false
              },
              {
                type: "text",
                text: "(J)",
                size: "sm",
                align: "start",
                color: "#AAAAAA"
              },
              {
                type: "text",
                text: "12",
                margin: "sm",
                align: "end"
              },
              {
                type: "text",
                text: "3350",
                align: "end"
              }
            ]
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "sm",
            contents: [
              {
                type: "text",
                text: "嚴浩平",
                margin: "md",
                align: "start",
                weight: "bold",
                wrap: false
              },
              {
                type: "text",
                text: "(B)",
                size: "sm",
                align: "start",
                color: "#AAAAAA"
              },
              {
                type: "text",
                text: "3",
                margin: "sm",
                align: "end"
              },
              {
                type: "text",
                text: "1220",
                align: "end"
              }
            ]
          },
          {
            type: "box",
            layout: "horizontal",
            spacing: "sm",
            contents: [
              {
                type: "text",
                text: "東錢",
                margin: "md",
                align: "start",
                weight: "bold",
                wrap: false
              },
              {
                type: "text",
                text: "($)",
                size: "sm",
                align: "start",
                color: "#AAAAAA"
              },
              {
                type: "text",
                text: "22",
                margin: "sm",
                align: "end"
              },
              {
                type: "text",
                text: "4400",
                align: "end"
              }
            ]
          }
        ]
      }
    }
  end

  def unbind_board
    {
      type: "bubble",
      direction: "ltr",
      header: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: "解除綁定",
            size: "xl",
            align: "center"
          }
        ]
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: "一個群組只能綁定一個麻將群組",
            align: "start"
          },
          {
            type: "text",
            text: "如果要換新群組請先解除綁定！"
          }
        ]
      },
      footer: {
        type: "box",
        layout: "horizontal",
        contents: [
          {
            type: "button",
            action: {
              type: "postback",
              label: "解除綁定",
              text: "我說解除！",
              data: "data: remove_group"
            }
          }
        ]
      }
    }
  end
end