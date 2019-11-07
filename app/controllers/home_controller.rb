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
end