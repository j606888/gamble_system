module Line::Reply::Message::Quick
  # not in use yet
  # "https://developers.line.biz/en/docs/messaging-api/using-quick-reply/"
  def sample_quick_reply
    {
      type: 'text',
      text: 'Welcome to sample quick reply, choose your action',
      quickReply: {
        items: [
          {
            type: 'action',
            action: sample_postback_action
          },
          {
            type: 'action',
            action: sample_message_action
          }
        ]
      }
    }
  end
end