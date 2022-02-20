class LiffController < ApplicationController
  skip_before_action :verify_authenticity_token
  # layout 'liff'

  def index
  end
  
  def users
    render json: { room_id: params[:room_id] }
  end

  def close_window
  end
end
