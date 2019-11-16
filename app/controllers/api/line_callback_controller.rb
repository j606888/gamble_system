class Api::LineCallbackController < Api::ApplicationController
  def index
    result = Line::Eventer.call(line_params['events'].first)
    
    unless result.success?
      puts result.error
      puts result.error.backtrace
    end

    render json: {status: 200}
  end

  private
  def line_params
    params.permit(events: [:type, :replyToken, :timestamp, source: [:userId, :groupId, :type], postback: {}, message:{}])
  end
end
  