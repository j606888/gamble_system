class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @user = User.new
  end
end