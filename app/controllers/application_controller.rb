class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_join_rooms

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message

    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private
  def set_join_rooms
    @join_rooms = Room.with_role(:member, current_user) if current_user
  end

  def set_current_room
    @room = Room.find(params[:room_id] || params[:id])
  end
end
