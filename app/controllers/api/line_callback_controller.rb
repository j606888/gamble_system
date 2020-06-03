class Api::LineCallbackController < Api::ApplicationController
  def index
    result = LineBot::Receiver.call(request)
    
    unless result.success?
      puts result.error
      puts result.error.backtrace
    end

    render json: {status: 200}
  end
end
  