class RolesController < ApplicationController
  def bash_update
    room = Room.find(params[:room_id])
    room.bash_update_roles(roles_params['roles'])
    flash[:success] = "Update Success"
    redirect_to control_room_path(room)
  end

  private
  def roles_params
    params.permit(roles: [:user_id, :admin, :member, :helper])
  end
end