class Liff::CallbackController < Liff::ApplicationController
  def text
    render layout: false
  end
end