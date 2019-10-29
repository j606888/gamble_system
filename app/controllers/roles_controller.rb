class RolesController < ApplicationController
  before_action :set_current_room

    def join
    result = @room.join(current_user, params[:password])
    if result == :success
      flash[:success] = "加入房間成功！"
      redirect_to @room
    else
      flash[:error] = "密碼錯誤！"
      redirect_to rooms_path
    end
  end

  def left
    if current_user.has_role?(:member, @room)
      current_user.remove_role(:member, @room)
      flash[:success] = "退出房間成功！"
    else
      flash[:warning] = "你本來就不在房間內了！"
    end
    redirect_to @room
  end

  private
  def roles_params
    params.permit(roles: [:user_id, :admin, :member])
  end
end