class Api::LineCallbackController < Api::ApplicationController
  def index
    LineBot.call(line_params['events'].first)
    render json: {status: 200}
  end

  private
  def line_params
    params.permit(events: [:type, :replyToken, :timestamp, source: [:userId, :groupId, :type], postback: {}, message:{}])
  end
end
  