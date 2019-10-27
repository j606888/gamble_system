class RolesController < ApplicationController
  before_action :set_current_room

  def bash_update
    @room.bash_update_roles(roles_params['roles'])
    flash[:success] = "Update Success"
    redirect_to control_room_path(@room)
  end

  def ask
    current_user.add_role(:ask, @room)
    flash[:success] = "已送出要求"
    redirect_to rooms_path
  end

  def reply_ask
    user = User.find(params[:user_id])
    answer = params[:answer]
    @room.reply_ask(user, answer)

    if answer == 'accept'
      flash[:success] = '已批准請求'
    else
      flash[:success] = '已移除請求'
    end

    redirect_to control_room_path(@room)
  end

  private
  def roles_params
    params.permit(roles: [:user_id, :admin, :member, :helper])
  end
end