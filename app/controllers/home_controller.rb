class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to welcome_path if current_user.present?

    @user = User.new
  end

  def help
  end

  def welcome
  end

  def advise
    if advise_params.present?
      AdviseTool.call(advise_params)
      AdviseMailer.remind.deliver_now

      flash[:success] = "感謝您的建議，我會盡快作出更新的！"
      redirect_to welcome_path
    end
  end

  private
  def advise_params
    params.permit(:name, :content)
  end
end