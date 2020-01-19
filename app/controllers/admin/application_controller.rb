class Admin::ApplicationController < ApplicationController
  before_action :admin_authorize!

  private
  def admin_authorize!
    redirect_to welcome_path unless current_user.has_role?(:admin)
  end
end