class Line::Event
  include Source
  include Message
  include Postback

  attr_accessor :type, :reply_token, :source, :postback, :message
  def initialize(event)
    @type = event['type']
    @reply_token = event['replyToken']
    @source = event['source']
    @postback = event['postback']
    @message = event['message']
  end
end