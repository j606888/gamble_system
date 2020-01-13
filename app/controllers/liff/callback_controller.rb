class Liff::CallbackController < Liff::ApplicationController
  skip_before_action :set_line_source

  def text
    @message = params[:message]
    render layout: false
  end
end