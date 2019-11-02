class Api::LineCallbackController < Api::ApplicationController
  def index
    LineBot.new(line_params['events'].first).call
    render json: {status: 200}
  end

  private
  def line_params
    params.permit(events: [:type, :replyToken, :timestamp, source: [:userId, :groupId, :type], message:{}])
  end
end
  