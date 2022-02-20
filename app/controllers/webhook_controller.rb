class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def line
    result = LineBot::Receiver.call(request)
    
    unless result.success?
      Rails.logger.info result.error
      Rails.logger.info result.error.backtrace
    end

    render json: {status: 200}
  end
end
