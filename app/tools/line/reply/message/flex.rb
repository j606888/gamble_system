module Line::Reply::Message::Flex
  # use for message with css 
  # https://developers.line.biz/en/docs/messaging-api/using-flex-messages/
  # https://developers.line.biz/en/reference/messaging-api/#flex-message

  # sample_flex_todo
  # sample_flex_transit
  def sample_flex_message
    {
      type: 'flex',
      altText: 'I am flex!',
      contents: sample_flex_transit
    }
  end

  def sample_flex_todo
    {
      "type": "carousel",
      "contents": [
        {
          "type": "bubble",
          "size": "nano",
          "header": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "In Progress",
                "color": "#ffffff",
                "align": "start",
                "size": "md",
                "gravity": "center"
              },
              {
                "type": "text",
                "text": "70%",
                "color": "#ffffff",
                "align": "start",
                "size": "xs",
                "gravity": "center",
                "margin": "lg"
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "width": "70%",
                    "backgroundColor": "#0D8186",
                    "height": "6px"
                  }
                ],
                "backgroundColor": "#9FD8E36E",
                "height": "6px",
                "margin": "sm"
              }
            ],
            "backgroundColor": "#27ACB2",
            "paddingTop": "19px",
            "paddingAll": "12px",
            "paddingBottom": "16px"
          },
          "body": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "Buy milk and lettuce before class",
                    "color": "#8C8C8C",
                    "size": "sm",
                    "wrap": true
                  }
                ],
                "flex": 1
              }
            ],
            "spacing": "md",
            "paddingAll": "12px"
          },
          "styles": {
            "footer": {
              "separator": false
            }
          }
        },
        {
          "type": "bubble",
          "size": "nano",
          "header": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "Pending",
                "color": "#ffffff",
                "align": "start",
                "size": "md",
                "gravity": "center"
              },
              {
                "type": "text",
                "text": "30%",
                "color": "#ffffff",
                "align": "start",
                "size": "xs",
                "gravity": "center",
                "margin": "lg"
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "width": "30%",
                    "backgroundColor": "#DE5658",
                    "height": "6px"
                  }
                ],
                "backgroundColor": "#FAD2A76E",
                "height": "6px",
                "margin": "sm"
              }
            ],
            "backgroundColor": "#FF6B6E",
            "paddingTop": "19px",
            "paddingAll": "12px",
            "paddingBottom": "16px"
          },
          "body": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "Wash my car",
                    "color": "#8C8C8C",
                    "size": "sm",
                    "wrap": true
                  }
                ],
                "flex": 1
              }
            ],
            "spacing": "md",
            "paddingAll": "12px"
          },
          "styles": {
            "footer": {
              "separator": false
            }
          }
        },
        {
          "type": "bubble",
          "size": "nano",
          "header": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "In Progress",
                "color": "#ffffff",
                "align": "start",
                "size": "md",
                "gravity": "center"
              },
              {
                "type": "text",
                "text": "100%",
                "color": "#ffffff",
                "align": "start",
                "size": "xs",
                "gravity": "center",
                "margin": "lg"
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "width": "100%",
                    "backgroundColor": "#7D51E4",
                    "height": "6px"
                  }
                ],
                "backgroundColor": "#9FD8E36E",
                "height": "6px",
                "margin": "sm"
              }
            ],
            "backgroundColor": "#A17DF5",
            "paddingTop": "19px",
            "paddingAll": "12px",
            "paddingBottom": "16px"
          },
          "body": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "Buy milk and lettuce before class",
                    "color": "#8C8C8C",
                    "size": "sm",
                    "wrap": true
                  }
                ],
                "flex": 1
              }
            ],
            "spacing": "md",
            "paddingAll": "12px"
          },
          "styles": {
            "footer": {
              "separator": false
            }
          }
        }
      ]
    }
  end

  def sample_flex_transit
    {
      "type": "bubble",
      "size": "mega",
      "header": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "FROM",
                "color": "#ffffff66",
                "size": "sm"
              },
              {
                "type": "text",
                "text": "Akihabara",
                "color": "#ffffff",
                "size": "xl",
                "flex": 4,
                "weight": "bold"
              }
            ]
          },
          {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "TO",
                "color": "#ffffff66",
                "size": "sm"
              },
              {
                "type": "text",
                "text": "Shinjuku",
                "color": "#ffffff",
                "size": "xl",
                "flex": 4,
                "weight": "bold"
              }
            ]
          }
        ],
        "paddingAll": "20px",
        "backgroundColor": "#0367D3",
        "spacing": "md",
        "height": "154px",
        "paddingTop": "22px"
      },
      "body": {
        "type": "box",
        "layout": "vertical",
        "contents": [
          {
            "type": "text",
            "text": "Total: 1 hour",
            "color": "#b7b7b7",
            "size": "xs"
          },
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "text",
                "text": "20:30",
                "size": "sm",
                "gravity": "center"
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "filler"
                  },
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "cornerRadius": "30px",
                    "height": "12px",
                    "width": "12px",
                    "borderColor": "#EF454D",
                    "borderWidth": "2px"
                  },
                  {
                    "type": "filler"
                  }
                ],
                "flex": 0
              },
              {
                "type": "text",
                "text": "Akihabara",
                "gravity": "center",
                "flex": 4,
                "size": "sm"
              }
            ],
            "spacing": "lg",
            "cornerRadius": "30px",
            "margin": "xl"
          },
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "box",
                "layout": "baseline",
                "contents": [
                  {
                    "type": "filler"
                  }
                ],
                "flex": 1
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "box",
                    "layout": "horizontal",
                    "contents": [
                      {
                        "type": "filler"
                      },
                      {
                        "type": "box",
                        "layout": "vertical",
                        "contents": [
                          {
                            "type": "filler"
                          }
                        ],
                        "width": "2px",
                        "backgroundColor": "#B7B7B7"
                      },
                      {
                        "type": "filler"
                      }
                    ],
                    "flex": 1
                  }
                ],
                "width": "12px"
              },
              {
                "type": "text",
                "text": "Walk 4min",
                "gravity": "center",
                "flex": 4,
                "size": "xs",
                "color": "#8c8c8c"
              }
            ],
            "spacing": "lg",
            "height": "64px"
          },
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "box",
                "layout": "horizontal",
                "contents": [
                  {
                    "type": "text",
                    "text": "20:34",
                    "gravity": "center",
                    "size": "sm"
                  }
                ],
                "flex": 1
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "filler"
                  },
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "cornerRadius": "30px",
                    "width": "12px",
                    "height": "12px",
                    "borderWidth": "2px",
                    "borderColor": "#6486E3"
                  },
                  {
                    "type": "filler"
                  }
                ],
                "flex": 0
              },
              {
                "type": "text",
                "text": "Ochanomizu",
                "gravity": "center",
                "flex": 4,
                "size": "sm"
              }
            ],
            "spacing": "lg",
            "cornerRadius": "30px"
          },
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "box",
                "layout": "baseline",
                "contents": [
                  {
                    "type": "filler"
                  }
                ],
                "flex": 1
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "box",
                    "layout": "horizontal",
                    "contents": [
                      {
                        "type": "filler"
                      },
                      {
                        "type": "box",
                        "layout": "vertical",
                        "contents": [
                          {
                            "type": "filler"
                          }
                        ],
                        "width": "2px",
                        "backgroundColor": "#6486E3"
                      },
                      {
                        "type": "filler"
                      }
                    ],
                    "flex": 1
                  }
                ],
                "width": "12px"
              },
              {
                "type": "text",
                "text": "Metro 1hr",
                "gravity": "center",
                "flex": 4,
                "size": "xs",
                "color": "#8c8c8c"
              }
            ],
            "spacing": "lg",
            "height": "64px"
          },
          {
            "type": "box",
            "layout": "horizontal",
            "contents": [
              {
                "type": "text",
                "text": "20:40",
                "gravity": "center",
                "size": "sm"
              },
              {
                "type": "box",
                "layout": "vertical",
                "contents": [
                  {
                    "type": "filler"
                  },
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [
                      {
                        "type": "filler"
                      }
                    ],
                    "cornerRadius": "30px",
                    "width": "12px",
                    "height": "12px",
                    "borderColor": "#6486E3",
                    "borderWidth": "2px"
                  },
                  {
                    "type": "filler"
                  }
                ],
                "flex": 0
              },
              {
                "type": "text",
                "text": "Shinjuku",
                "gravity": "center",
                "flex": 4,
                "size": "sm"
              }
            ],
            "spacing": "lg",
            "cornerRadius": "30px"
          }
        ]
      }
    }
  end
end